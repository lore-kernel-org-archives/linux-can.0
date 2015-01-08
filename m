From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH V2 2/2] bfin_can: rewrite the driver to support the common
Date: Thu, 8 Jan 2015 10:13:23 +0100
Message-ID: <20150108091322.GE9157@distanz.ch>
References: <1420700254-22529-1-git-send-email-Aaron.wu@analog.com>
 <1420700254-22529-2-git-send-email-Aaron.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:38971 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754118AbbAHJN1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 Jan 2015 04:13:27 -0500
Content-Disposition: inline
In-Reply-To: <1420700254-22529-2-git-send-email-Aaron.wu@analog.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Aaron Wu <Aaron.wu@analog.com>
Cc: mkl@pengutronix.de, wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net

On 2015-01-08 at 07:57:34 +0100, Aaron Wu <Aaron.wu@analog.com> wrote:
> Rewrite the driver to comply to common style with MMU 
> 
> Signed-off-by: Aaron Wu <Aaron.wu@analog.com>
> ---
>  drivers/net/can/bfin_can.c |   21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
> index 0a5eff4..1d116a7 100644
> --- a/drivers/net/can/bfin_can.c
> +++ b/drivers/net/can/bfin_can.c
[...]
> @@ -617,9 +615,6 @@ static int bfin_can_remove(struct platform_device *pdev)
>  
>  	unregister_candev(dev);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, resource_size(res));
> -

struct resource *res will be unused in bfin_can_remove() after this
change, so it should be removed as well.
