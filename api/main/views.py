from django.shortcuts import render
from django.http import HttpResponse
from django.http.response import JsonResponse

from api.settings import HOST_IP

def Index(request):
    version = "1.02.00"
    # Compute BASE_URL from request to include host and port
    base_url = request.build_absolute_uri('/')
    return render(request,'index.html',{
        "version": version,
        "AUTOR": "Mateo Negri, Valentina Barrera",
        "DESCRIPCION": "MAPUNS - MAPA DE ALUMNOS UNS",
        "NOMBRE": "MAPUNS",
        "BASE_URL": base_url
    })

def Dashboard(request):
    return JsonResponse({
        "success": True,
        "ejemplo": {
            "percent": 10,
            "value": 1,
        },
    })
