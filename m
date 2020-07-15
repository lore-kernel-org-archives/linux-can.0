From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: CAN network drivers
Date: Wed, 15 Jul 2020 15:46:53 -0600
Message-ID: <20200715214653.GA872937@bogus>
References: <20200705075606.22802-1-grandmaster@al2klimov.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200705075606.22802-1-grandmaster-ecYmzcxolEDucvZx32VAuQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Alexander A. Klimov" <grandmaster-ecYmzcxolEDucvZx32VAuQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, leon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kuba-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, masahiroy-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sriram.dash-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hpeter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Sun, 05 Jul 2020 09:56:06 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster-ecYmzcxolEDucvZx32VAuQ@public.gmane.org>
> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  Documentation/devicetree/bindings/net/can/grcan.txt |  2 +-
>  drivers/net/can/grcan.c                             |  2 +-
>  drivers/net/can/m_can/m_can.c                       |  2 +-
>  drivers/net/can/m_can/m_can.h                       |  2 +-
>  drivers/net/can/m_can/m_can_platform.c              |  2 +-
>  drivers/net/can/m_can/tcan4x5x.c                    |  2 +-
>  drivers/net/can/sja1000/Kconfig                     | 12 ++++++------
>  drivers/net/can/sja1000/tscan1.c                    |  2 +-
>  drivers/net/can/slcan.c                             |  2 +-
>  drivers/net/can/ti_hecc.c                           |  4 ++--
>  drivers/net/can/usb/Kconfig                         |  6 +++---
>  11 files changed, 19 insertions(+), 19 deletions(-)
> 

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
