From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V6 2/2] can: flexcan: add self wakeup support
Date: Mon, 26 Nov 2018 12:34:10 +0100
Message-ID: <7b1215df-f1ea-c366-17ff-bc5265e58ffa@pengutronix.de>
References: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
 <20181123083304.3232-3-qiangqing.zhang@nxp.com>
 <1be643fb-e966-fc2d-d19f-2a1e45b58641@pengutronix.de>
 <DB7PR04MB46180404F4201A8FAA52400FE6D70@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB46180404F4201A8FAA52400FE6D70@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

On 11/26/18 2:12 AM, Joakim Zhang wrote:
> Firstly, thanks for reviewing the patch. Then, I am confused to do
> upstream on "linux-can" or "linux-can-next" due to I find "linux-can"
> is more updated than "linux-can-next".
linux-can is for fixes aginat the current net/master.
linux-can-next is for new features against net-next/master.

I just updates both branches and pushed linux-can-next/testing, too,
which is going the be the next pull request.

regards,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
