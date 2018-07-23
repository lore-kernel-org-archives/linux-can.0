From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
Date: Mon, 23 Jul 2018 11:57:33 +0000
Message-ID: <20180723115733.GA6529@osadl.at>
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
 <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
 <4f81e688-3d5c-6174-5a76-f416ced63cf3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4f81e688-3d5c-6174-5a76-f416ced63cf3@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>, Nicholas Mc Guire <hofrat@osadl.org>, Wolfram Sang <w.sang@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Mon, Jul 23, 2018 at 01:37:05PM +0200, Marc Kleine-Budde wrote:
> On 07/09/2018 09:28 PM, Fabio Estevam wrote:
> > On Mon, Jul 9, 2018 at 4:16 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >>  of_iompa() can return NULL so that return needs to be checked and NULL
> > 
> > s/of_iompa/of_iomap/
> > 
> >> treated as failure. While at it also take care of the missing
> >> of_node_put() in the error path.
> >>
> >> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> >> Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & mpc52xx_mscan")
> >> ---
> >>
> >> Problem was found by an experimental coccinelle script
> >>
> >> Patch was compiletested with: mpc5200_defconfig + CONFIG_CAN=y,
> >> CONFIG_CAN_MSCAN=y, CONFIG_CAN_MPC5XXX=y
> >> (with a number of sparse warnings not related to the proposed change)
> >>
> >> Patch is against 4.18-rc3 (localversion-next is next-20180706)
> >>
> >>  drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
> >> index c7427bd..2949a38 100644
> >> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> >> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> >> @@ -86,6 +86,11 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
> >>                 return 0;
> >>         }
> >>         cdm = of_iomap(np_cdm, 0);
> >> +       if (!cdm) {
> >> +               of_node_put(np_cdm);
> >> +               dev_err(&ofdev->dev, "can't map clock node!\n");
> >> +               return 0;
> > 
> > I think you should return an error code here. -ENOMEM maybe?
> 
> Can you send an updated version?
>
The way I understand the code the return value will be used
as a frequency - the only valid error valeu thus is 0 here,
so I think the return 0 is correct.

thx!
hofrat
