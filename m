From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/7] Documentation: networking: arcnet: drop doubled word
Date: Fri,  3 Jul 2020 15:41:09 -0700
Message-ID: <20200703224115.29769-2-rdunlap@infradead.org>
References: <20200703224115.29769-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200703224115.29769-1-rdunlap@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-hams@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
List-Id: linux-can.vger.kernel.org

Drop the doubled word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
---
 Documentation/networking/arcnet.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/networking/arcnet.rst
+++ linux-next-20200701/Documentation/networking/arcnet.rst
@@ -434,7 +434,7 @@ can set up your network then:
 	ifconfig arc0 insight
 	route add insight arc0
 	route add freedom arc0	/* I would use the subnet here (like I said
-					to to in "single protocol" above),
+					to in "single protocol" above),
 					but the rest of the subnet
 					unfortunately lies across the PPP
 					link on freedom, which confuses
