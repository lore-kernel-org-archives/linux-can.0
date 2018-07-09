From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
Date: Mon, 9 Jul 2018 16:28:41 -0300
Message-ID: <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Mon, Jul 9, 2018 at 4:16 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:
>  of_iompa() can return NULL so that return needs to be checked and NULL

s/of_iompa/of_iomap/

> treated as failure. While at it also take care of the missing
> of_node_put() in the error path.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & mpc52xx_mscan")
> ---
>
> Problem was found by an experimental coccinelle script
>
> Patch was compiletested with: mpc5200_defconfig + CONFIG_CAN=y,
> CONFIG_CAN_MSCAN=y, CONFIG_CAN_MPC5XXX=y
> (with a number of sparse warnings not related to the proposed change)
>
> Patch is against 4.18-rc3 (localversion-next is next-20180706)
>
>  drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
> index c7427bd..2949a38 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -86,6 +86,11 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
>                 return 0;
>         }
>         cdm = of_iomap(np_cdm, 0);
> +       if (!cdm) {
> +               of_node_put(np_cdm);
> +               dev_err(&ofdev->dev, "can't map clock node!\n");
> +               return 0;

I think you should return an error code here. -ENOMEM maybe?
