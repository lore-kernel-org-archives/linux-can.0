From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 3/7] Documentation: networking: can_ucan_protocol: drop doubled words
Date: Fri,  3 Jul 2020 15:41:11 -0700
Message-ID: <20200703224115.29769-4-rdunlap@infradead.org>
References: <20200703224115.29769-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200703224115.29769-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-hams@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
List-Id: linux-can.vger.kernel.org

Drop the doubled words "the" and "of".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
---
 Documentation/networking/can_ucan_protocol.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/networking/can_ucan_protocol.rst
+++ linux-next-20200701/Documentation/networking/can_ucan_protocol.rst
@@ -144,7 +144,7 @@ UCAN_COMMAND_SET_BITTIMING
 
 *Host2Dev; mandatory*
 
-Setup bittiming by sending the the structure
+Setup bittiming by sending the structure
 ``ucan_ctl_payload_t.cmd_set_bittiming`` (see ``struct bittiming`` for
 details)
 
@@ -232,7 +232,7 @@ UCAN_IN_TX_COMPLETE
   zero
 
 The CAN device has sent a message to the CAN bus. It answers with a
-list of of tuples <echo-ids, flags>.
+list of tuples <echo-ids, flags>.
 
 The echo-id identifies the frame from (echos the id from a previous
 UCAN_OUT_TX message). The flag indicates the result of the
