From: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Subject: Re: [PATCH v3] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Thu, 06 Dec 2012 05:28:40 +0100
Message-ID: <50C01EF8.8020107@universalnet.at>
References: <50BE6092.9050602@universalnet.at> <50BE6F0E.80308@pengutronix.de> <50BF8602.1070909@universalnet.at> <50BFBF60.2090106@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BFBF60.2090106-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hi Mark!

Am 2012-12-05 22:40, schrieb Marc Kleine-Budde:
> On 12/05/2012 06:36 PM, Bernd Krumboeck wrote:
>> Hi Marc!
>>
>>
>>>> +    default:
>>>> +        netdev_info(netdev, "Rx URB aborted (%d)\n",
>>>> +             urb->status);
>>>> +        goto resubmit_urb;
>>>> +    }
>>>> +
>>>> +    while (pos < urb->actual_length) {
>>>> +        struct usb_8dev_rx_msg *msg;
>>>> +
>>>> +        if (pos + sizeof(struct usb_8dev_rx_msg) >
>>>> urb->actual_length) {
>>>> +            netdev_err(dev->netdev, "format error\n");
>>>> +            break;
>>>
>>> is resubmitting the urb the correct way to handle this problem?
>>
>> Suggestions? (maybe CAN_ERR_CRTL_UNSPEC ??)
>
> It's not an error on the CAN protocol level, but the USB communication
> is broken. I just had a look at the kvaser usb driver, it's doing a
> resubmit, too. So it seems to be okay.
>

I suggested CAN_ERR_CRTL_UNSPEC not CAN_ERR_PROT_UNSPEC. ;-)

>>
>>>> +
>>>> +            stats->tx_dropped++;
>>>> +        }
>>>> +    } else {
>>>> +        /* Slow down tx path */
>>>> +        if (atomic_read(&dev->active_tx_urbs) >= MAX_TX_URBS ||
>>>> +            dev->free_slots < 5) {
>>>
>>> where's the 5 coming from?
>>>
>>
>>  From ems_usb driver.
>
> Hmmmm, is the variable free_slots used?

Ahm, no.

>>>
>>> Have you actually tested one shot? What happens if a can frame cannot be
>>> transmitted?
>>>
>>
>> Not really. Can someone explain what one-shot exactly means and what is
>> the correct behavior.
>> I've only tested without any other device connected. I got the same
>> errors like in normal mode.
>
> Can has a built in collision avoidance protocol. If a collision is about
> to happen the sender with the higher CAN id will back of and try again
> later. In one shot mode it will not try again. The question is, how
> behaves the dongle firmware, as you have to free your tx message somehow.
>
> To test, simply send with one station with canid 1, the other one in
> one-shot-mode with canid 0x7ff.
>

Thanks for the explanation, maybe Gerd can test. I still have no other device. :-(


regards,
Bernd

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
