From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] can: peak_pci: Make structure peak_pciec_i2c_bit_ops constant
Date: Mon, 19 Aug 2019 13:30:18 +0530
Message-ID: <20190819080018.2155-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>
List-Id: linux-can.vger.kernel.org

Static structure peak_pciec_i2c_bit_ops, of type i2c_algo_bit_data, is
not used except to be copied into another variable. Hence make it const
to protect it from modification.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/net/can/sja1000/peak_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 68366d57916c..8c0244f51059 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -417,7 +417,7 @@ static void peak_pciec_write_reg(const struct sja1000_priv *priv,
 	peak_pci_write_reg(priv, port, val);
 }
 
-static struct i2c_algo_bit_data peak_pciec_i2c_bit_ops = {
+static const struct i2c_algo_bit_data peak_pciec_i2c_bit_ops = {
 	.setsda	= pita_setsda,
 	.setscl	= pita_setscl,
 	.getsda	= pita_getsda,
-- 
2.19.1
