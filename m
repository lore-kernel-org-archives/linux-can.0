From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Flooding AT91_CAN peripheral with messages causes it to stop
 receiving any more messages
Date: Fri, 3 Jun 2016 09:22:32 +0200
Message-ID: <57513038.2080107@grandegger.com>
References: <CAOLz05quWjxFaxdPcLvybc4YdTmE+qUGhbKUCjji6DGNAUwZ3g@mail.gmail.com>
 <1834894.mYn6oCiL2x@ws-stein> <57275BE6.5060905@grandegger.com>
 <CAOLz05qzdyPk2CoUZH4F0-b5syJDQehN6rEBoVo-7fpngQgxPw@mail.gmail.com>
 <CAOLz05qKWrDK2f6tg9wyY6HsQp1m=jvN+KF4v5z2u0xUakSQCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.140]:56734 "EHLO
	mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbcFCHWx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Jun 2016 03:22:53 -0400
In-Reply-To: <CAOLz05qKWrDK2f6tg9wyY6HsQp1m=jvN+KF4v5z2u0xUakSQCw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amr Bekhit <amrbekhit@gmail.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, mkl@pengutronix.de, linux-can@vger.kernel.org

Hello Amr,

I'm resending this message because it did not show up on the linux-can 
mailing list archive...

Am 01.06.2016 um 15:21 schrieb Amr Bekhit:
> Hi Wolfgang and Alexander,
>
> @Wolfgang: using the patch you sent to me, I ran the test twice until
> the unit stopped responding to messages. After taking the can
> interface down, here is the output from the console for both tests:
>
> # ifconfig can0 down
> at91_can f8004000.can can0: reg_sr=1
> at91_can f8004000.can can0: tx_next=0
> at91_can f8004000.can can0: tx_echo=0
> at91_can f8004000.can can0: rx_next=6
>
> # ifconfig can0 down
> at91_can f8004000.can can0: reg_sr=1
> at91_can f8004000.can can0: tx_next=8042
> at91_can f8004000.can can0: tx_echo=8042
> at91_can f8004000.can can0: rx_next=6

Trying to understand why RX stopped: at91_poll() entered with all RX 
message boxes filled (reg_sr=1, rx_next=6). Because "quota" is exceeded, 
the following if block is not executed:

http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L713

At the next entrance of at91_poll(), at91_poll_rx() is *not* called, 
because reg_sr is 0 and the RX MB interrupts are not re-enabled, because 
rx_next is still 6. The RX interrupts stay *disabled*.

If I'm not wrong, the following patch should fix that problem:

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 945c095..c9f36a4 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -733,9 +733,10 @@ static int at91_poll_rx(struct net_device *dev, int 
quota)

         /* upper group completed, look again in lower */
         if (priv->rx_next > get_mb_rx_low_last(priv) &&
-           quota > 0 && mb > get_mb_rx_last(priv)) {
+           mb > get_mb_rx_last(priv)) {
                 priv->rx_next = get_mb_rx_first(priv);
-               goto again;
+               if (quota > 0)
+                       goto again;
         }

         return received;

Could you give this patch a try, please.

> I've also tried out the patch suggested by Alexander and that seems to
> work fine - I was unable to get the CAN device to lock up after
> running it for over a day continuously (test repeated twice). As I
> understood it, the aim of the patch was to get the messages out of the
> CAN peripheral immediately during the interrupt and store them in a
> kfifo for later processing. From my testing, this does appear to have
> solved the problem (or severely reduced the probability of it
> happening).

The existing driver may loose messages due to latency, but it should not 
stop working.

Wolfgang.

> On 3 May 2016 at 09:27, Amr Bekhit <amrbekhit@gmail.com> wrote:
>> Hi Wolfgang and Alexander,
>>
>> Thanks for both of your responses.
>>
>>
>> @Alexander: Thanks for pointing out the patch.
>>
>> @Wolfgang: In response to your earlier request, I've uploaded my dts
>> file to pastebin, which can find at http://pastebin.com/tNp2PnW4. I'll
>> give the patch mentioned by Alexander and your one a try and let you
>> know how it goes.
>>
>> Amr
>>
>> On 2 May 2016 at 14:53, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>> Hello Alexander,
>>>
>>> Am 02.05.2016 um 08:23 schrieb Alexander Stein:
>>>>
>>>> On Tuesday 05 April 2016 14:10:48, Amr Bekhit wrote:
>>>>>
>>>>> I working on a board based on the AT91SAM9X25 SoC and I'm using
>>>>> integrated CAN peripheral. I seem to have run into an issue whereby
>>>>> sending lots of messages very rapidly in quick succession causes the
>>>>> CAN peripheral to then stop receiving any messages at all. The only
>>>>> way to bring it back to a functional state is to bring the network
>>>>> interface down and then back up again.
>>>>> [...]
>>>>> I then start sending CAN messages to the unit using a PCAN-USB adapter
>>>>> that is plugged into a test Linux PC. After bringing up the CAN
>>>>> interface on the test PC, messages can be continuously sent using the
>>>>> following bash script:
>>>>> [...]
>>>>> I then leave the system running for some time (1.5 hours typically,
>>>>> may vary), periodically running ifconfig can0 to check to see if new
>>>>> packets are being received. After a while, the can interface will stop
>>>>> receiving new packets, even though the test PC is still transmitting
>>>>> them. Stopping and restarting the CAN transmissions on the test PC
>>>>> does not solve the problem. The interface does not appear to be in the
>>>>> bus off state, as shown by running the following:
>>>>
>>>>
>>>> That sounds a bit like my getting stuck problem in
>>>> http://linux-can.vger.kernel.narkive.com/bBQqK84G/resend-patch-net-can-at91-can-c-decrease-likelyhood-of-rx-overruns#post2
>>>>
>>>> The patch post1 at least keeps the driver working. Although I don't know
>>>> what
>>>> has changed in at91_can meanwhile.
>>>
>>>
>>> Thanks for pointing me to that patch. It still applies to Linux 4.1 with
>>> some minor fixes. Amr, could you please give it a try. Please let me know if
>>> you need help.
>>>
>>> Anyway, I think the driver should not hang even in case of overflows. I will
>>> have a closer look later this week.
>>>
>>> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
