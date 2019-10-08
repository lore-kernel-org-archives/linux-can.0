From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: pull-request: can-next 2019-10-07
Date: Tue, 8 Oct 2019 12:09:53 -0700
Message-ID: <20191008120953.515a3dbd@cakuba.netronome.com>
References: <2ffa00e7-d447-9216-587d-30396a47ca64@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <2ffa00e7-d447-9216-587d-30396a47ca64@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Bastian Stender <bst@pengutronix.de>, Elenita Hinds <ecathinds@gmail.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Maxime Jayat <maxime.jayat@mobile-devices.fr>, Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <ore@pengutronix.de>, David Jander <david@protonic.nl>
List-Id: linux-can.vger.kernel.org

On Mon, 7 Oct 2019 16:38:14 +0200, Marc Kleine-Budde wrote:
> Hello David,
> 
> this is a pull request for net-next/master consisting of 12 patches.
> 
> The first patch is by Andy Shevchenko for the mcp251x driver and removes
> the legacy platform data from all in-tree users and the driver.
> 
> The next two patches target the peak_canfd driver, the first one is by
> me and fixes several checkpatch warnings, the second one is by Stephane
> Grosjean and adds hardware timestamps to the rx skbs.
> 
> Followed by two patches for the xilinx_can driver. Again the first is by
> me and fixes checkpatch warnings, the second one is by Anssi Hannula and
> avoids non-requested bus error frames, which improves performance.
> 
> Pankaj Sharma's patch for the m_can driver adds support for the one shot
> mode.
> 
> YueHaibing provides a patch for the grcan driver to use
> devm_platform_ioremap_resource() to simplify code.
> 
> Joakim Zhang provides a similar patch for the flexcan driver.
> 
> The last 4 patches are by me and target the rx-offload infrastructure.
> The first 3 fix checkpatch warnings, the last one removes a no-op
> function.

Hi Marc,

I think the correction should have been s/Substract/Subtract/,
sorry for the nit pick.

Would you be able to fix that up or do you prefer to do a follow up?

commit 8e7f9a874626a1aec191b34c2b983f76275d0448
Author: Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Mon Oct 7 10:00:25 2019 +0200

    can: rx-offload: can_rx_offload_compare(): fix typo
    
    This patch fixes a typo found by checkpatch.
    
    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 0daa8c7fe83b..8db07587ce3c 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -109,7 +109,7 @@ static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
        cb_a = can_rx_offload_get_cb(a);
        cb_b = can_rx_offload_get_cb(b);
 
-       /* Substract two u32 and return result as int, to keep
+       /* Substact two u32 and return result as int, to keep
         * difference steady around the u32 overflow.
         */
        return cb_b->timestamp - cb_a->timestamp;
