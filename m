From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/13] can: j1939: fix address claim code example
Date: Mon,  9 Dec 2019 17:32:47 +0100
Message-ID: <20191209163256.12000-5-mkl@pengutronix.de>
References: <20191209163256.12000-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191209163256.12000-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, Oleksij Rempel <o.rempel@pengutronix.de>
List-Id: linux-can.vger.kernel.org

During development the define J1939_PGN_ADDRESS_REQUEST was renamed to
J1939_PGN_REQUEST. It was forgotten to adjust the documentation
accordingly.

This patch fixes the name of the symbol.

Reported-by: https://github.com/linux-can/can-utils/issues/159#issuecomment-556538798
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/j1939.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/j1939.rst b/Documentation/networking/j1939.rst
index dc60b13fcd09..f5be243d250a 100644
--- a/Documentation/networking/j1939.rst
+++ b/Documentation/networking/j1939.rst
@@ -339,7 +339,7 @@ To claim an address following code example can be used:
 			.pgn = J1939_PGN_ADDRESS_CLAIMED,
 			.pgn_mask = J1939_PGN_PDU1_MAX,
 		}, {
-			.pgn = J1939_PGN_ADDRESS_REQUEST,
+			.pgn = J1939_PGN_REQUEST,
 			.pgn_mask = J1939_PGN_PDU1_MAX,
 		}, {
 			.pgn = J1939_PGN_ADDRESS_COMMANDED,
-- 
2.24.0
