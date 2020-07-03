From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 7/7] Documentation: networking: rxrpc: drop doubled word
Date: Fri,  3 Jul 2020 15:41:15 -0700
Message-ID: <20200703224115.29769-8-rdunlap@infradead.org>
References: <20200703224115.29769-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgGCWlu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Jul 2020 18:41:50 -0400
In-Reply-To: <20200703224115.29769-1-rdunlap@infradead.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-hams@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org

Drop the doubled word "have".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org
---
 Documentation/networking/rxrpc.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/networking/rxrpc.rst
+++ linux-next-20200701/Documentation/networking/rxrpc.rst
@@ -186,7 +186,7 @@ About the AF_RXRPC driver:
      time [tunable] after the last connection using it discarded, in case a new
      connection is made that could use it.
 
- (#) A client-side connection is only shared between calls if they have have
+ (#) A client-side connection is only shared between calls if they have
      the same key struct describing their security (and assuming the calls
      would otherwise share the connection).  Non-secured calls would also be
      able to share connections with each other.
