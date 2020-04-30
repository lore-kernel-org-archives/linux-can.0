From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 09/37] docs: networking: convert netdevices.txt to ReST
Date: Thu, 30 Apr 2020 18:04:04 +0200
Message-ID: <bd505d26902d26d2a06601867cb576b27f47bff3.1588261997.git.mchehab+huawei@kernel.org>
References: <cover.1588261997.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1588261997.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

- add SPDX header;
- adjust title markup;
- mark lists as such;
- adjust identation, whitespaces and blank lines;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/can.rst              |  2 +-
 Documentation/networking/index.rst            |  1 +
 .../{netdevices.txt => netdevices.rst}        | 21 ++++++++++++-------
 3 files changed, 16 insertions(+), 8 deletions(-)
 rename Documentation/networking/{netdevices.txt => netdevices.rst} (89%)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 2fd0b51a8c52..ff05cbd05e0d 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1058,7 +1058,7 @@ drivers you mainly have to deal with:
 - TX: Put the CAN frame from the socket buffer to the CAN controller.
 - RX: Put the CAN frame from the CAN controller to the socket buffer.
 
-See e.g. at Documentation/networking/netdevices.txt . The differences
+See e.g. at Documentation/networking/netdevices.rst . The differences
 for writing CAN network device driver are described below:
 
 
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 4c6aa3db97d4..5a320553ffba 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -82,6 +82,7 @@ Contents:
    multiqueue
    netconsole
    netdev-features
+   netdevices
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/netdevices.txt b/Documentation/networking/netdevices.rst
similarity index 89%
rename from Documentation/networking/netdevices.txt
rename to Documentation/networking/netdevices.rst
index 7fec2061a334..5a85fcc80c76 100644
--- a/Documentation/networking/netdevices.txt
+++ b/Documentation/networking/netdevices.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
 
+=====================================
 Network Devices, the Kernel, and You!
+=====================================
 
 
 Introduction
@@ -75,11 +78,12 @@ ndo_start_xmit:
 	Don't use it for new drivers.
 
 	Context: Process with BHs disabled or BH (timer),
-	         will be called with interrupts disabled by netconsole.
+		 will be called with interrupts disabled by netconsole.
 
-	Return codes: 
-	o NETDEV_TX_OK everything ok. 
-	o NETDEV_TX_BUSY Cannot transmit packet, try later 
+	Return codes:
+
+	* NETDEV_TX_OK everything ok.
+	* NETDEV_TX_BUSY Cannot transmit packet, try later
 	  Usually a bug, means queue start/stop flow control is broken in
 	  the driver. Note: the driver must NOT put the skb in its DMA ring.
 
@@ -95,10 +99,13 @@ ndo_set_rx_mode:
 struct napi_struct synchronization rules
 ========================================
 napi->poll:
-	Synchronization: NAPI_STATE_SCHED bit in napi->state.  Device
+	Synchronization:
+		NAPI_STATE_SCHED bit in napi->state.  Device
 		driver's ndo_stop method will invoke napi_disable() on
 		all NAPI instances which will do a sleeping poll on the
 		NAPI_STATE_SCHED napi->state bit, waiting for all pending
 		NAPI activity to cease.
-	Context: softirq
-	         will be called with interrupts disabled by netconsole.
+
+	Context:
+		 softirq
+		 will be called with interrupts disabled by netconsole.
-- 
2.25.4
