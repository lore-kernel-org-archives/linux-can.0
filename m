From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 1/2] can: Allwinner A10/A20 CAN
 Controller support - Devicetree bindings
Date: Sun, 13 Sep 2015 14:25:51 +0200
Message-ID: <20150913122551.GR9885@lukather>
References: <1442144632-4541-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442144632-4541-2-git-send-email-info@gerhard-bertelsmann.de>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JB7KW7Ey7eB5HOHs"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBXGW2WXQKGQEPNXPKFA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442144632-4541-2-git-send-email-info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>
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

--JB7KW7Ey7eB5HOHs
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Sun, Sep 13, 2015 at 01:43:51PM +0200, Gerhard Bertelsmann wrote:
> Signed-off-by: Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>

A commit log would be nice.

> ---
>  .../devicetree/bindings/net/can/sunxi_can.txt      |  40 +
>  1 files changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/sunxi_can.txt b/Documentation/devicetree/bindings/net/can/sunxi_can.txt
> new file mode 100644
> index 0000000..5db9abc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/sunxi_can.txt
> @@ -0,0 +1,40 @@
> +Allwinner A10/A20 CAN controller Device Tree Bindings
> +-----------------------------------------------------
> +
> +Required properties:
> +- compatible: "allwinner,sunxican"

The compatible should be made using the earliest SoC using this IP. In
our case, that would be the A10.

The format we use is sun4i-a10-<ip>, which would make it sun4i-a10-can
in this case.

> +- reg: physical base address and size of the Allwinner A10/A20 CAN register map.
> +- interrupts: interrupt specifier for the sole interrupt.
> +- clocks: phandle and clock specifier

Which clock?

> +- pinctrl-0: pin control group to be used for this controller.
> +- pinctrl-names: must be "default".

Those are generic standalone properties. There's no really need to
mention them.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--JB7KW7Ey7eB5HOHs--
