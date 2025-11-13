FROM ubuntu:25.10

# ENV for Qt
ENV DEBIAN_FRONTEND=noninteractive \
    LIBGL_ALWAYS_INDIRECT=1 \
    QT_DEBUG_PLUGINS=1 \
    QT_QUICK_BACKEND=software \
    QT_QPA_PLATFORM=xcb

RUN apt-get update && apt-get install -y adduser

# Add user 'qtuser'
RUN adduser --quiet --disabled-password qtuser \
    && usermod -a -G audio qtuser

# Install Python 3 and PyQt6
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-venv \
    qt6-base-dev \
    && rm -rf /var/lib/apt/lists/*

#Install latest version of LiveboxMonitor
RUN pip install --no-cache-dir --break-system-packages LiveboxMonitor

# Run LiveboxMonitor by default when container starts
CMD ["LiveboxMonitor"]

