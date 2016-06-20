From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Bug? -- NEVER getting controller-problem{back-to-error-active}
Date: Mon, 20 Jun 2016 15:31:11 +0200
Message-ID: <5767F01F.50700@grandegger.com>
References: <loom.20160620T110554-742@post.gmane.org>
 <5767C65D.2010303@grandegger.com> <loom.20160620T145908-586@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.151]:53468 "EHLO
	mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbcFTNbO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2016 09:31:14 -0400
In-Reply-To: <loom.20160620T145908-586@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org


Am 20.06.2016 um 15:00 schrieb ajneu:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
>
>>
>> Does the following patch fix both issues?
>>
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>> index ce44a03..ca17ac2 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>   <at>  <at>  -529,7 +529,7  <at>  <at>  static int
> pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
>>          struct peak_usb_device *dev =
> usb_if->dev[pucan_stmsg_get_channel(sm)];
>>          struct pcan_usb_fd_device *pdev =
>>                          container_of(dev, struct pcan_usb_fd_device, dev);
>> -       enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
>> +       enum can_state new_state;
>>          enum can_state rx_state, tx_state;
>>          struct net_device *netdev = dev->netdev;
>>          struct can_frame *cf;
>>   <at>  <at>  -547,10 +547,7  <at>  <at>  static int
> pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
>>                  new_state = CAN_STATE_ERROR_WARNING;
>>          } else {
>>                  /* no error bit (so, no error skb, back to active state) */
>> -               dev->can.state = CAN_STATE_ERROR_ACTIVE;
>> -               pdev->bec.txerr = 0;
>> -               pdev->bec.rxerr = 0;
>> -               return 0;
>> +               new_state = CAN_STATE_ERROR_ACTIVE;
>>          }
>>
>>          /* state hasn't changed */
>>
>> Wolfgang.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo <at> vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
>
> Hi Wolfgang,
>
> yes wonderful: you patch works (and solves both issues)!
> Will it be going into the mainline linux kernel?

I'm going to prepare a patch for mainline inclusion. Can I add your 
"Tested-by: ajneu <ajneu1@gmail.com>"?

Wolfgang.
