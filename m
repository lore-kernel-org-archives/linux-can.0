From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 4/7] Documentation: networking: dsa: drop doubled word
Date: Fri,  3 Jul 2020 15:41:12 -0700
Message-ID: <20200703224115.29769-5-rdunlap@infradead.org>
References: <20200703224115.29769-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200703224115.29769-1-rdunlap@infradead.org>
Sender: netdev-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-hams@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
List-Id: linux-can.vger.kernel.org

Drop the doubled word "in".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/dsa/dsa.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/networking/dsa/dsa.rst
+++ linux-next-20200701/Documentation/networking/dsa/dsa.rst
@@ -95,7 +95,7 @@ Ethernet switch.
 Networking stack hooks
 ----------------------
 
-When a master netdev is used with DSA, a small hook is placed in in the
+When a master netdev is used with DSA, a small hook is placed in the
 networking stack is in order to have the DSA subsystem process the Ethernet
 switch specific tagging protocol. DSA accomplishes this by registering a
 specific (and fake) Ethernet type (later becoming ``skb->protocol``) with the
