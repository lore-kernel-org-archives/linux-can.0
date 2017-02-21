From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: bug in DT docs vs mcp251x.c driver
Date: Tue, 21 Feb 2017 15:47:51 -0300
Message-ID: <CAOMZO5BCcQYNr6qV0qhmRGTBm030kNWyErO66_HOD0A5huYM3A@mail.gmail.com>
References: <1d36bb5b-b46a-8e9a-672b-907cac5c5ab4@elpromaelectronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1d36bb5b-b46a-8e9a-672b-907cac5c5ab4-cjVIcFy54eMe9JSWTWOYM+658FiBabzs@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki-cjVIcFy54eMe9JSWTWOYM+658FiBabzs@public.gmane.org>
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "l.dalek elpromaelectronics.com" <l.dalek-cjVIcFy54eMe9JSWTWOYM+658FiBabzs@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Janusz,

On Tue, Feb 21, 2017 at 3:08 PM, Janusz U=C5=BCycki
<j.uzycki-cjVIcFy54eMe9JSWTWOYM+658FiBabzs@public.gmane.org> wrote:
> Hi,
>
> We've noticed the inconsistency in DT which still exist in kernel v4.10:
>
> devm_regulator_get(&spi->dev, "vdd") in drivers/net/can/mcp251x.c
>
> vs vdd-supply: Regulator that powers the CAN controller. in
> bindings/net/can/microchip,mcp251x.txt

This is correct.

When the regulator is retrieved as devm_regulator_get(dev, "xyz") then
it searches for a xyz-supply in the dts.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
