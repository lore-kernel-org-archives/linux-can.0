From: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 1/6] can: dev: Add support for limiting configured
 bitrate
Date: Wed, 3 Jan 2018 17:51:40 +0530
Message-ID: <5dadca68-f8ae-e708-5a5f-5d2a8876cf40@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>
 <8d973da8-df40-e37e-377f-50666db382fe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8d973da8-df40-e37e-377f-50666db382fe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hi,

On Tuesday 02 January 2018 09:45 PM, Marc Kleine-Budde wrote:
> On 12/22/2017 02:31 PM, Faiz Abbas wrote:
>> From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>>
>> Various CAN or CAN-FD IP may be able to run at a faster rate than
>> what the transceiver the CAN node is connected to. This can lead to
>> unexpected errors. However, CAN transceivers typically have fixed
>> limitations and provide no means to discover these limitations at
>> runtime. Therefore, add support for a can-transceiver node that
>> can be reused by other CAN peripheral drivers to determine for both
>> CAN and CAN-FD what the max bitrate that can be used. If the user
>> tries to configure CAN to pass these maximum bitrates it will throw
>> an error.
> 
> Please add support to read the maximum bitrate via netlink. Have a look
> at 12a6075cabc0 ("can: dev: add CAN interface termination API"). I think
> you need to extend the following functions: can_get_size() and
> can_fill_info().

Will add in the next version.

Thanks,
Faiz

> 
> Marc
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
