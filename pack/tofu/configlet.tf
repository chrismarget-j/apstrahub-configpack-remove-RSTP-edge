#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_datacenter_configlet" "example" {
  name = var.name
  blueprint_id =  var.blueprint_id
  condition = "role in [\"leaf\", \"access\"]"
  generators = [
    {
      config_style  = "junos"
      section       = "top_level_set_delete"
      template_text = <<-EOT
        {% for if_name,if_param in interface.items() %}
          {% for tags in if_param['tags'] %}
           {% if tags == "no-rstp-edge" %}
        delete protocols rstp interface {{ if_param['intfName'] }} edge
            {% endif %}
          {% endfor %}
        {% endfor %}
      EOT
    },
  ]
}
