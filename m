From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH v4] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 05 Dec 2012 17:31:58 +0100
Message-ID: <50BF76FE.1090706@grandegger.com>
References: <50BE7C7E.8080406@universalnet.at> <50BF1E58.4090603@grandegger.com> <50BF6D05.4070609@volkswagen.de> <50BF6F93.9050107@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BF6F93.9050107-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Oliver Hartkopp <oliver.hartkopp-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>, Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

On 12/05/2012 05:00 PM, Marc Kleine-Budde wrote:
> On 12/05/2012 04:49 PM, Oliver Hartkopp wrote:
>> On 05.12.2012 11:13, Wolfgang Grandegger wrote:
>>
>>>> +    outmsg.command = USB_8DEV_OPEN;
>>>> +    outmsg.opt1 = USB_8DEV_BAUD_MANUAL;
>>>> +    outmsg.data[0] = (bt->prop_seg + bt->phase_seg1);
>>>
>>> Minor issue. Brackets not needed.
>>>
>>>> +    outmsg.data[1] = bt->phase_seg2;
>>>> +    outmsg.data[2] = bt->sjw;
>>>> +
>>
>> That's correct from a compilers point of view.
>> But in this case i would preserve the [0] as it is better to read in
>> conjunction with the two lines below ( ..[1] ..[2] )
>>
>> The semantic has to be understood by humans ;-)
> 
> I think Wolfgang was talking about the round bracket not the square
> bracket. :D

Yep. Sorry for confusion.

Wolfgang.


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
