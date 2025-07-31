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
        {% for interface_name, interface_data in interface.items() %}
            {% if interface_data.role == "l2edge" and interface_data.part_of == "" and interface_data.allowed_vlans %}
                {% for vlan_id in interface_data.allowed_vlans %}
        set protocols loop-detect enhanced interface {{ interface_data.intfName }}.0 vlan-id {{ vlan_id }}
                {% endfor %}
        set protocols loop-detect enhanced interface {{ interface_data.intfName }}.0 loop-detect-action interface-down
        set protocols loop-detect enhanced interface {{ interface_data.intfName }}.0 transmit-interval 1s
        set protocols loop-detect enhanced interface {{ interface_data.intfName }}.0 revert-interval 120s
            {% endif %}
        {% endfor %}
      EOT
    },
  ]
}
