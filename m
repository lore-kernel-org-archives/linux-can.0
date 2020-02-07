From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 0/2] Convert bosch,m_can to json-schema
Date: Fri, 7 Feb 2020 10:51:11 +0100
Message-ID: <20200207095113.14489-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com, sriram.dash@samsung.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-can.vger.kernel.org

The goal of this series is to convert bosch,m_can bindings to json-schema.
First convert can-transceiver to yaml and then use it for bosch,m_can.yaml.

version 3:
- only declare max-bitrate property in can-transceiver.yaml
- move can-transceive node into bosch,m_can.yaml bindings

Benjamin Gaignard (2):
  dt-bindinsg: net: can: Convert can-transceiver to json-schema
  dt-bindings: net: can: Convert M_CAN to json-schema

 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 147 +++++++++++++++++++++
 .../bindings/net/can/can-transceiver.txt           |  24 ----
 .../bindings/net/can/can-transceiver.yaml          |  18 +++
 .../devicetree/bindings/net/can/m_can.txt          |  75 -----------
 4 files changed, 165 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt

-- 
2.15.0
