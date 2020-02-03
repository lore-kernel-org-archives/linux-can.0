From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] dt-bindings: net: can: m_can: Add Documentation for
 stb-gpios
Date: Mon, 3 Feb 2020 12:06:10 +0000
Message-ID: <20200203120610.GA9303@bogus>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
 <20200122080310.24653-2-faiz_abbas@ti.com>
 <c3b0eeb8-bd78-aa96-4783-62dc93f03bfe@ti.com>
 <8fc7c343-267d-c91c-0381-60990cfc35e8@ti.com>
 <f834087b-da1c-88a0-93fe-bc72c8ac71ff@ti.com>
 <57baeedc-9f51-7b92-f190-c0bbd8525a16@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57baeedc-9f51-7b92-f190-c0bbd8525a16-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Cc: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, sriram.dash-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Thu, Jan 23, 2020 at 01:09:41PM +0530, Faiz Abbas wrote:
> Hi,
> 
> On 22/01/20 8:04 pm, Dan Murphy wrote:
> > Sekhar
> > 
> > On 1/22/20 8:24 AM, Sekhar Nori wrote:
> >> On 22/01/20 7:05 PM, Dan Murphy wrote:
> >>> Faiz
> >>>
> >>> On 1/22/20 2:03 AM, Faiz Abbas wrote:
> >>>> The CAN transceiver on some boards has an STB pin which is
> >>>> used to control its standby mode. Add an optional property
> >>>> stb-gpios to toggle the same.
> >>>>
> >>>> Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
> >>>> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> >>>> ---
> >>>>    Documentation/devicetree/bindings/net/can/m_can.txt | 2 ++
> >>>>    1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt
> >>>> b/Documentation/devicetree/bindings/net/can/m_can.txt
> >>>> index ed614383af9c..cc8ba3f7a2aa 100644
> >>>> --- a/Documentation/devicetree/bindings/net/can/m_can.txt
> >>>> +++ b/Documentation/devicetree/bindings/net/can/m_can.txt
> >>>> @@ -48,6 +48,8 @@ Optional Subnode:
> >>>>                  that can be used for CAN/CAN-FD modes. See
> >>>>                
> >>>> Documentation/devicetree/bindings/net/can/can-transceiver.txt
> >>>>                  for details.
> >>>> +stb-gpios        : gpio node to toggle the STB (standby) signal on
> >>>> the transceiver
> >>>> +
> >>> The m_can.txt is for the m_can framework.  If this is specific to the
> >>> platform then it really does not belong here.
> >>>
> >>> If the platform has specific nodes then maybe we need a
> >>> m_can_platform.txt binding for specific platform nodes.  But I leave
> >>> that decision to Rob.
> >> Since this is transceiver enable, should this not be in
> >> Documentation/devicetree/bindings/net/can/can-transceiver.txt?
> > 
> 
> The transceiver node is just a node without an associated device. I had
> tried to convert it to a phy implementation but that idea got shot down
> here:
> 
> https://lore.kernel.org/patchwork/patch/1006238/

Nodes and drivers are not a 1-1 thing. Is the transceiver a separate h/w 
device? If so, then it should be a separate node and properties of that 
device go in its node. Also, nothing is stopping you from using the PHY 
binding without using the kernel's PHY framework.

As to whether it should be a separate phy driver, I think probably the 
wrong decision was made. We always seem to start out with no PHY on 
these things and the complexity just grows until we need one. 

Rob
