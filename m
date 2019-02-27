From: pisa@cmp.felk.cvut.cz
Subject: [PATCH v2 0/2] dt-bindings: net: can: binding for CTU CAN FD open-source IP core.
Date: Wed, 27 Feb 2019 18:26:27 +0100
Message-ID: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com, ondrej.ille@gmail.com, Pavel Pisa <pisa@cmp.felk.cvut.cz>
List-Id: linux-can.vger.kernel.org

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

The patch update, added separate patch to add Czech Technical University
to the vendors list. Change ctu_can_fd_0 instance string to lowercase
(originally uppercase because build from official abbreviations).
Clarify that clock-names are not used for now but can be used in future.

Pavel Pisa (2):
  dt-bindings: vendor-prefix: add prefix for Czech Technical University
    in Prague.
  dt-bindings: net: can: binding for CTU CAN FD open-source IP core.

The corresponding sources for testing program from user-space
and for Linux kernel driver for platform and PCIe IP core
integrations are available there

  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core/tree/master/driver/

 .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 108 +++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 2 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt

-- 
2.11.0
