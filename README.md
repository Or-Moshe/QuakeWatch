![Screenshot of QuakeWatch](static/experts-logo.svg)

# QuakeWatch

**QuakeWatch** is a Flask-based web application designed to display real-time and historical earthquake data. It visualizes earthquake statistics with interactive graphs and provides detailed information sourced from the USGS Earthquake API. Built using an object‑oriented design and modular structure, QuakeWatch separates templates, utility functions, and route definitions, making it both scalable and maintainable. The application is also containerized with Docker for easy deployment.

## Features

- **Real-Time & Historical Data:** Fetches earthquake data from the USGS API.
- **Interactive Graphs:** Displays earthquake counts over various time periods (e.g., last 30 days, 5-year view) using Matplotlib.
- **Top Earthquake Events:** Shows the top 5 worldwide earthquakes (last 30 days) by magnitude.
- **Recent Earthquake Details:** Highlights the most recent earthquake event.
- **RESTful Endpoints:** Provides endpoints for health checks, status, connectivity tests, and raw data.
- **Clean UI:** Built with Bootstrap 5, featuring a professional navigation bar with a logo.
- **Dockerized:** Easily containerized for streamlined deployment.

## Project Structure

```
QuakeWatch/
├── project-charts          # helm charts
│   │   ├──Chart.yaml
│   │   ├──values.yaml
│   │   ├──values-dev.yaml
│   │   ├──values-prod.yaml
│   │   ├──values-stage.yaml
│   │   └── charts
│   │   │   └── quakewatch
│   │   │   │   ├──Chart.yaml
│   │   │   │   ├──values.yaml
│   │   │   │   └── templates
│   │   │   │   │   ├── configmap.yaml
│   │   │   │   │   ├── cronjob.yaml
│   │   │   │   │   ├── development.yaml
│   │   │   │   │   ├── hpa.yaml
│   │   │   │   │   ├── ingress.yaml
│   │   │   │   │   ├── pv.yaml
│   │   │   │   │   ├── pvc.yaml
│   │   │   │   │   ├── service.yaml  
├── app.py                  # Application factory and entry point
├── dashboard.py            # Blueprint & route definitions using OOP style
├── utils.py                # Helper functions and custom Jinja2 filters
├── requirements.txt        # Python dependencies
├── static/
│   └── experts-logo.svg    # Logo file used in the UI
└── templates/              # Jinja2 HTML templates
    ├── base.html           # Base template with common layout and navigation
    ├── main_page.html      # Home page content
    └── graph_dashboard.html# Dashboard view with graphs and earthquake details
```

## Installation

### Locally

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/QuakeWatch.git
   cd QuakeWatch
   ```

2. **Set Up a Virtual Environment (optional but recommended):**

   ```bash
   python -m venv venv
   source venv/bin/activate   # On Windows: venv\Scripts\activate
   ```

3. **Install Dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

## Running the Application Locally

1. **Start the Flask Application:**

   ```bash
   python app.py
   ```

2. **Access the Application:**

   Open your browser and visit [http://127.0.0.1:5000](http://127.0.0.1:5000) to view the dashboard.


## Custom Jinja2 Filter

The project includes a custom filter `timestamp_to_str` that converts epoch timestamps to human-readable strings. This filter is registered during application initialization and is used in the templates to format earthquake event times.

## Known Issues

- **SSL Warning:** You might see a warning regarding LibreSSL when using urllib3. This is informational and does not affect the functionality of the application.
- **Matplotlib Backend:** The application forces Matplotlib to use the `Agg` backend for headless rendering. Ensure this setting is applied before any Matplotlib imports to avoid GUI-related errors.


## phase4

**run the application**
1. go to the cluster of your app.
2. run:
```commandline
kubectl port-forward svc/quake-watch-phase3-svc {YOUR_AVAILABLE_PORT}:5000
```

**creating a helm chart release:**
   1. go to chart folder:
        cd project-charts
    
   2. ```bash
      helm upgrade -i quakewatch -f values-dev.yaml ./
      ```
**Monitoring using ArgoCD**
1. create new namespace:
    ```bash
      kubectl create namespace argocd
    ```
2. installation and getting password:
    ```bash
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" -n argocd| base64 -d; echo
    [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String((kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}')))
    ```
3. running:
    ```bash
    kubectl port-forward svc/argocd-server -n argocd 8080:443
    https://localhost:8080/applications
    ```

**Monitoring using prometheus and grafana**

installation:
```bash
git clone https://github.com/EduardUsatchev/advanced-devops.git
cd advanced-devops/monitoring/k8s-setup
minikube start --driver=docker
1. kubectl apply -f monitoring/namespace.yml
2. helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
3. helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
4. helm upgrade -i prometheus prometheus-community/prometheus --namespace monitoring -f prometheus/values.yml
5. kubectl apply -f monitoring/grafana/config.yml
6. helm repo add grafana https://grafana.github.io/helm-charts
7. helm install grafana --namespace monitoring grafana/grafana --set rbac.pspEnabled=false
```

running:
```bash
8. kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
9. kubectl -n monitoring port-forward svc/grafana 3000:80 
10. kubectl -n monitoring port-forward svc/prometheus-prometheus-node-exporter 9100:9100 
11. kubectl -n monitoring port-forward svc/prometheus-prometheus-pushgateway 9091:9091 
12. kubectl -n monitoring port-forward svc/prometheus-server 9090:80 
13: Sending metrics to pushgateway: echo "some_metric 52" | curl --data-binary @- http://localhost:9091/metrics/job/some_job/a/b
14. helm install my-release oci://registry-1.docker.io/bitnamicharts/redis --set metrics.enabled=true
15. kubectl port-forward svc/my-release-redis-metrics 9121:9121
16. kubectl -n monitoring port-forward svc/prometheus-alertmanager 9093:9093
17. kubectl -n monitoring port-forward svc/prometheus-prometheus-pushgateway 9091:9091
```

**Grafana**

prometheus server is running on port 80 so configure the connection of data source as:
http://prometheus-server:80

**Alert Manager**
to add new rule you should edit the config map:
```commandline
 kubectl edit configmap prometheus-server -n monitoring
```