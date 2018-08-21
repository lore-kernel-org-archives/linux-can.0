From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 05/11] can: rcar: use SPDX identifier for Renesas drivers
Date: Tue, 21 Aug 2018 19:45:24 -0300
Message-ID: <CAOMZO5AkVNiYMGdED9erL=YMaKcmtS5BzZxw2gO1KLXEaPnD7A@mail.gmail.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com> <20180821220233.9202-6-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821220233.9202-6-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Philippe Ombredanne <pombredanne@nexb.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hi Wolfram,

On Tue, Aug 21, 2018 at 7:02 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> To be applied individually per subsystem tree. Morimoto-san, could you maybe
> ack this with your Renesas address?
>
>  drivers/net/can/rcar/rcar_can.c   | 6 +-----
>  drivers/net/can/rcar/rcar_canfd.c | 6 +-----
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
> index 11662f479e76..051bf4ef4be2 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

According to Documentation/process/license-rules.rst the format should
be like this instead:

// SPDX-License-Identifier: GPL-2.0+
