From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 0/2] can: Allwinner A10/A20 CAN
 Controller support - summary
Date: Sun, 13 Sep 2015 14:22:27 +0200
Message-ID: <20150913122227.GQ9885@lukather>
References: <1442144632-4541-1-git-send-email-info@gerhard-bertelsmann.de>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L0TNCHh3fkwjpuuE"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBD6V2WXQKGQEE2EP2FY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442144632-4541-1-git-send-email-info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-can.vger.kernel.org

--L0TNCHh3fkwjpuuE
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Gerhard,

Thanks for working on this!

A few questions / remarks though:

On Sun, Sep 13, 2015 at 01:43:50PM +0200, Gerhard Bertelsmann wrote:
> Hi,
> 
> please find attached the next try. Thanks to Marc. I've worked on
> all mentioned issues except one: I don't add clk_disable_unprepare
> in sunxi_can_start. Makes no sense to me (driver fails).
> 
> For testers:
> the patch will only apply wihtout modification to kernels 3.19+.

Please always make sure to send a patch that have been tested and
applies at least on top of the latest rc. This would be 4.3-rc1 now.

> I've tested the driver (receipt, sending and basic errors). IMHO
> everything is fine. The performance seems to be good - high rates
> (>5000 packets/second) working fine.
> 
> Please test and report bugs if exists.
> 
> 
> [PATCH v5 1/2] Device Tree Binding Documentation
> [PATCH v5 2/2] Kernel Module
> 
> History:
>     V5: fix license
>         modify prefix to mode select defines
>         enable and disable clock in sunxican_get_berr_counter
> 	delete set_normal_mode at the end of sunxi_can_start
> 	removed sunxican_id_table
> 	use devm_clk_get instead of clk_get
> 	use devm_ioremap_resource to simplify probe and remove
> 	make set-normal-mode and set-reset-mode more readable
>         
>     v4: defines prefixed with SUNXI_
>         sunxi_can_write_cmdreg tweaked
> 	loops in set_xxx_mode reworked
> 	add return value to set_xxx_mode
> 	sunxican_start_xmit reworked
> 	struct platform_driver stripped
> 	moved set_bittiming into open
> 	moved clock start into open
> 	add clock stop to close
>         suspend reworked
>         resume reworked
>         fixed double counting bug
> 
>     v3: changed error state change handling (thx Andri for the hint)
>         use bittiming function correct (no need to call it)
>         strip down priv (suggested by Marc)
>         scripts/checkpatch.pl-> no matches anymore
>         sparse -> no errors or warnings anymore
>     v2: cleaning
>     v1: initial

Where were those versions posted ?

Make sure to run get_maintainer before sending your patches to mail
them to the right recipients.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--L0TNCHh3fkwjpuuE--
