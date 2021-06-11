
# Personalización de Wordpress
Comandos para la personalización:

## Actualizaciones:

### Actualización de los plugins a la última versión
```
wp plugin update --all --allow-root
```
### Actualización de los themes a la última versión
```
wp theme update --all --allow-root
```
### Actualizar el core a la última versión
```
wp core update --allow-root
```
## Plugin:

### Listar los plugins:
```
wp plugin list -allow-root
```
### Instalar y activar plugins:
```
wp plugin install bbpress --activate --allow-root
```
### Desactivar un plugin:
```
wp plugin deactivate bbpress --allow-root
```

### Eliminar un plugin:
```
wp plugin delete bbpress --allow-root
```

### Eliminar los plugins que están inactivos:
```
wp plugin delete $(wp plugin list --status=inactive --field=name) --allow-root
```

## Themes:

### Listar los themes instalados
```
wp theme list --allow-root
```

### Activar un theme
```
wp theme activate twentytwenty --allow-root
```

### Eliminar un theme
```
wp theme delete sydney --allow-root
```

### Eliminar los themes que están inactivos
```
wp theme delete $(wp theme list --status=inactive --field=name) --allow-root
```
