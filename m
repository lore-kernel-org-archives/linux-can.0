From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH] can: m_can: select pinctrl state in each suspend/resume
 function
Date: Mon, 12 Mar 2018 08:52:37 +0000
Message-ID: <1520844745-5865-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Mario Huettel <mario.huettel@gmx.net>, Faiz Abbas <faiz_abbas@ti.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Franklin S Cooper Jr <fcooper@ti.com>, Arnd Bergmann <arnd@arndb.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-can.vger.kernel.org

Make sure to apply the correct pin state in suspend/resume callbacks.
Putting pins in sleep state saves power.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/net/can/m_can/m_can.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2594f77..a86ef69 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1700,6 +1700,8 @@ static __maybe_unused int m_can_suspend(struct device *dev)
 		m_can_clk_stop(priv);
 	}
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	priv->can.state = CAN_STATE_SLEEPING;
 
 	return 0;
@@ -1710,6 +1712,8 @@ static __maybe_unused int m_can_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_priv *priv = netdev_priv(ndev);
 
+	pinctrl_pm_select_default_state(dev);
+
 	m_can_init_ram(priv);
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
-- 
1.9.1
