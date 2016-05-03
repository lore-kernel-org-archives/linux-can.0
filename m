From: Amr Bekhit <amrbekhit@gmail.com>
Subject: Re: Flooding AT91_CAN peripheral with messages causes it to stop
 receiving any more messages
Date: Tue, 3 May 2016 09:27:52 +0100
Message-ID: <CAOLz05qzdyPk2CoUZH4F0-b5syJDQehN6rEBoVo-7fpngQgxPw@mail.gmail.com>
References: <CAOLz05quWjxFaxdPcLvybc4YdTmE+qUGhbKUCjji6DGNAUwZ3g@mail.gmail.com>
 <1834894.mYn6oCiL2x@ws-stein> <57275BE6.5060905@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35834 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbcECI2N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 May 2016 04:28:13 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so135775189wme.0
        for <linux-can@vger.kernel.org>; Tue, 03 May 2016 01:28:12 -0700 (PDT)
In-Reply-To: <57275BE6.5060905@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, mkl@pengutronix.de, linux-can@vger.kernel.org

Hi Wolfgang and Alexander,

Thanks for both of your responses.


@Alexander: Thanks for pointing out the patch.

@Wolfgang: In response to your earlier request, I've uploaded my dts
file to pastebin, which can find at http://pastebin.com/tNp2PnW4. I'll
give the patch mentioned by Alexander and your one a try and let you
know how it goes.

Amr

On 2 May 2016 at 14:53, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hello Alexander,
>
> Am 02.05.2016 um 08:23 schrieb Alexander Stein:
>>
>> On Tuesday 05 April 2016 14:10:48, Amr Bekhit wrote:
>>>
>>> I working on a board based on the AT91SAM9X25 SoC and I'm using
>>> integrated CAN peripheral. I seem to have run into an issue whereby
>>> sending lots of messages very rapidly in quick succession causes the
>>> CAN peripheral to then stop receiving any messages at all. The only
>>> way to bring it back to a functional state is to bring the network
>>> interface down and then back up again.
>>> [...]
>>> I then start sending CAN messages to the unit using a PCAN-USB adapter
>>> that is plugged into a test Linux PC. After bringing up the CAN
>>> interface on the test PC, messages can be continuously sent using the
>>> following bash script:
>>> [...]
>>> I then leave the system running for some time (1.5 hours typically,
>>> may vary), periodically running ifconfig can0 to check to see if new
>>> packets are being received. After a while, the can interface will stop
>>> receiving new packets, even though the test PC is still transmitting
>>> them. Stopping and restarting the CAN transmissions on the test PC
>>> does not solve the problem. The interface does not appear to be in the
>>> bus off state, as shown by running the following:
>>
>>
>> That sounds a bit like my getting stuck problem in
>> http://linux-can.vger.kernel.narkive.com/bBQqK84G/resend-patch-net-can-at91-can-c-decrease-likelyhood-of-rx-overruns#post2
>>
>> The patch post1 at least keeps the driver working. Although I don't know
>> what
>> has changed in at91_can meanwhile.
>
>
> Thanks for pointing me to that patch. It still applies to Linux 4.1 with
> some minor fixes. Amr, could you please give it a try. Please let me know if
> you need help.
>
> Anyway, I think the driver should not hang even in case of overflows. I will
> have a closer look later this week.
>
> Wolfgang.
