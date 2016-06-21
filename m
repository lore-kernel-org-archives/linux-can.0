From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: Bug? -- NEVER getting controller-problem{back-to-error-active}
Date: Tue, 21 Jun 2016 10:29:30 +0200
Message-ID: <eccb6d7c-b451-8f8a-d6c1-c2675002d424@peak-system.com>
References: <loom.20160620T110554-742@post.gmane.org>
 <5767C65D.2010303@grandegger.com> <loom.20160620T145908-586@post.gmane.org>
 <5767F01F.50700@grandegger.com> <loom.20160620T154404-130@post.gmane.org>
 <5767FD85.9020701@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:50615 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbcFUIii (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2016 04:38:38 -0400
In-Reply-To: <5767FD85.9020701@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org

Hi,

The reason of this:

         } else {
                 /* no error bit (so, no error skb, back to active stat=
e) */
                 dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
                 pdev->bec.txerr =3D 0;
                 pdev->bec.rxerr =3D 0;
                 return 0;
         }

is given by the comment: AFAIR in these times, going (back) to=20
ACTIVE_STATE was made like above, by the device driver itself.

The lower condition:

         /* allocate an skb to store the error frame */
         skb =3D alloc_can_err_skb(netdev, &cf);
         if (skb)
                 can_change_state(netdev, cf, tx_state, rx_state);

uses can_change_state() if and only if "skb" is not NULL, while there=20
was no need of any skb to go (back) to ACTIVE_STATE.

So, I suppose that the proposed change should also include something=20
like the following one:

          /* allocate an skb to store the error frame */
          skb =3D alloc_can_err_skb(netdev, &cf);
-        if (skb)
+        if (skb || (new_state =3D=3D CAN_STATE_ERROR_ACTIVE))
                  can_change_state(netdev, cf, tx_state, rx_state);

St=E9phane

Le 20/06/2016 =E0 16:28, Wolfgang Grandegger a =E9crit :
> hello,
>
> Am 20.06.2016 um 15:53 schrieb ajneu:
>> Wolfgang Grandegger <wg <at> grandegger.com> writes:
>>
>>>
>>>
>>> Am 20.06.2016 um 15:00 schrieb ajneu:
>>>> Hi Wolfgang,
>>>>
>>>> yes wonderful: you patch works (and solves both issues)!
>>>> Will it be going into the mainline linux kernel?
>>>
>>> I'm going to prepare a patch for mainline inclusion. Can I add your
>>> "Tested-by: ajneu <ajneu1 <at> gmail.com>"?
>>
>> Well ok, you may.
>> (Just note I only tested the bugs I reported, and can confirm: those=
=20
>> bugs
>> are gone. I cannot account for any side-effects, since I didn't do a=
ny
>> "complete" tests. But scanning the code (*briefly*) it looks sortof=20
>> ok...
>
> Yes, the changes are obvious. Don't understand why=20
> CAN_STATE_ERROR_ACTIVE is handled differently. I have added the autho=
r.
>
>> Just question: Your change eliminates
>>     dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
>> where dev references usb_if, which is passed into the function as=20
>> parameter.
>> Is it ok to eliminate that call??
>> (Perhaps its equiv to the line
>>     can_change_state(netdev, cf, tx_state, rx_state);
>> which is called somewhat lower???)
>
> The state is set in can_change_state().:
>
> http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L341
>
> Wolfgang.

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183=20
Geschaeftsfuehrung: A.Gach, U.Wilhelm
--
