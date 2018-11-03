From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/6] phy: Add max_bitrate attribute &
 phy_get_max_bitrate()
Date: Sat, 3 Nov 2018 10:36:25 +0100
Message-ID: <5e1a0b67-510a-5512-d477-0b363e4733fe@pengutronix.de>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
 <20181102192616.28291-2-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102192616.28291-2-faiz_abbas@ti.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com
List-Id: linux-can.vger.kernel.org

On 11/02/2018 08:26 PM, Faiz Abbas wrote:
> In some subsystems (eg. CAN) the physical layer capabilities are
> the limiting factor in the datarate of the device. Typically, the
> physical layer transceiver does not provide a way to discover this
> limitation at runtime. Thus this information needs to be represented as
> a phy attribute which is read from the device tree.
> 
> Therefore, add an optional max_bitrate attribute to the generic phy
> sybsystem. Also add the complementary API which enables the consumer
> to get max_bitrate.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

NACK - We already have such a functionality in the CAN subsystem.
Please have a look at the patches:

e759c626d826 can: m_can: Support higher speed CAN-FD bitrates
b54f9eea7667 dt-bindings: can: m_can: Document new can transceiver binding
2290aefa2e90 can: dev: Add support for limiting configured bitrate
54a7fbcc17bc dt-bindings: can: can-transceiver: Document new binding

regards,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
