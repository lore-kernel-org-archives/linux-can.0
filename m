From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [RFC PATCH] CAN MAINTAINERS
Date: Fri, 02 Dec 2011 14:34:53 +0100
Message-ID: <4ED8D3FD.60301@grandegger.com>
References: <48E9EDF6.4000009@pengutronix.de>	<4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com>	<4ED745F6.8030302@pengutronix.de>	<4ED7494F.6080603@grandegger.com>	<4ED74AC7.40605@pengutronix.de>	<4ED75BD0.6070802@hartkopp.net>
	<4ED75EED.6010009@pengutronix.de>	<4ED89050.3040201@hartkopp.net>
	<4ED8C2EB.1070507@pengutronix.de> <4ED8C5D8.6000505@grandegger.com>
	<4ED8CF58.3010109@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4ED8CF58.3010109-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, Urs Thuermann <urs-5sm3ckEb1NlYFmeL5InDC7NAH6kLmebB@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Oliver,

On 12/02/2011 02:15 PM, Oliver Hartkopp wrote:
> On 02.12.2011 13:34, Wolfgang Grandegger wrote:
> 
>> Hi Marc,
>>
>> On 12/02/2011 01:22 PM, Marc Kleine-Budde wrote:
>>> On 12/02/2011 09:46 AM, Oliver Hartkopp wrote:
>>>> Hey Marc,
>>>>
>>>> i'm not as good as you using git. Indeed i'm a git newbie and do not have the
>>>> time right now to get in that deep that i dare to post correct pull requests
>>>> to netdev.
>>>>
>>>> Following the hints from Dave i checked the MAINTAINERS file how the wireless
>>>> guys handle their subsystem in detail. Regarding John Linville, who's
>>>> collecting all the stuff from several people to send finally push requests to
>>>> Dave i would suggest that you become our 'John Linville for CAN'.
>>>
>>> Wolfgang and me talked about this (via PM), too. We do the job together,
>>> but I send the pull requests to Dave.
>>
>> Thanks!
> 
> 
> Many thanks!
> 
>>
>>>> You speak git fluently and you know the project very good - so my suggestion
>>>> to clean up the MAINTAINTERS file is this:
>>>
>>> The cleanups look got, however, do we need the linux-can tree. Do the
>>> wireless people have two trees?
>>
>> I would drop it for the time being.
> 
> 
> Ok. So we stick to use Daves net-tree for fixes and send patches for the
> net-tree the old way, right?

Don't now what Dave's preference is.

>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 717d9e9..af8a0a9 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1707,11 +1707,8 @@ F:	arch/x86/include/asm/tce.h
>>>>
>>>>  CAN NETWORK LAYER
>>>>  M:	Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
>>>> -M:	Oliver Hartkopp <oliver.hartkopp-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
>>>> -M:	Urs Thuermann <urs.thuermann-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
>>>>  L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> -L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>
>>> this should focus the discussion on linux-can
>>
>> Well, but I think the patches still need to be presented on the netdev
>> ml? We should clarify that.
> 
> 
> I already thought about that too.
> 
> I think for CAN drivers there's no need for extra discussions on netdev.
> But for net/can changes i would always post the patches on linux-can and
> netdev to get the networking guys like Eric and Patrick into the loop for a
> review.
> 
> Btw. we should ask if Dave would like the stuff from our linux-can-next only
> as pull request or additionally in full source code.

As the patch goes through Dave's tree, I think the patch *must* be
posted on the netdev ML.

> Just to make it sure: When there are new ideas in net/can i would only post
> RFCs on netdev & linux-can. And once there is no new feedback - what would be
> the correct way:
> 
> - send it on netdev and then acked-by Marc

Either you, Marc or myself will pick it up and push it onto the
linux-can-next tree. We will need to add a "signed-off-by" then!!!
I does make sense to have a separate branch for development where we can
push our changes to and then Marc merges them to the "to-net-next"
branch. Note also that we need to rebase our patches regularly (re-sync
with net-next), especially before sending the pull request. But Marc
knows better...

> - send it on linux-can, push it into linux-can-next, and send a pull request?

Well, we still need to define the procedure. We could also use the
patchwork infrastructure to handle the patches.

...

> Here is an update:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 717d9e9..7417c92 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1707,11 +1707,8 @@ F:	arch/x86/include/asm/tce.h
> 
>  CAN NETWORK LAYER
>  M:	Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
> -M:	Oliver Hartkopp <oliver.hartkopp-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
> -M:	Urs Thuermann <urs.thuermann-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
>  L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -W:	http://developer.berlios.de/projects/socketcan/
> +W:	http://gitorious.org/linux-can
>  S:	Maintained
>  F:	net/can/
>  F:	include/linux/can.h
> @@ -1722,9 +1719,9 @@ F:	include/linux/can/gw.h
> 
>  CAN NETWORK DRIVERS
>  M:	Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
> +M:	Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>  L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -W:	http://developer.berlios.de/projects/socketcan/
> +W:	http://gitorious.org/linux-can
>  S:	Maintained
>  F:	drivers/net/can/
>  F:	include/linux/can/dev.h
> @@ -4587,6 +4584,16 @@ F:	include/linux/wireless.h
>  F:	include/net/iw_handler.h
>  F:	drivers/net/wireless/
> 
> +NETWORKING [CAN]
> +M:	Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> +L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +W:	http://gitorious.org/linux-can
> +T:	git://gitorious.org/linux-can/linux-can-next.git
> +S:	Maintained
> +F:	net/can/
> +F:	drivers/net/can/
> +F:	include/linux/can*
> +

Please drop the entry above and move the "T" line to the CAN NETWORK
DRIVERS and PROTOCOL entries. can/net changes have also go through the
git repository.

Wolfgang.
