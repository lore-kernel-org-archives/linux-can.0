From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: j1939
Date: Mon, 19 Sep 2016 21:44:34 +0200
Message-ID: <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:21223 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbcISTop (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2016 15:44:45 -0400
In-Reply-To: <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>



On 09/19/2016 08:52 PM, Marc Kleine-Budde wrote:
> On 09/19/2016 08:27 PM, Oliver Hartkopp wrote:
>> On 09/19/2016 06:54 PM, Marc Kleine-Budde wrote:
>>
>>>
>>> Another thing that IMHO has to be sorted out is the use of module
>>> parameters:
>>>
>>>> ./main.c:49:MODULE_PARM_DESC(padding, "Pad all packets to 8 bytes, and stuff with 0xff");
>>>> ./transport.c:60:MODULE_PARM_DESC(transport_burst_count, "Number of packets to send in burst between flow control (1..255, default 255)");
>>>> ./transport.c:61:MODULE_PARM_DESC(transport_max_size, "Maximum packet size (default 100k)");
>>>> ./transport.c:62:MODULE_PARM_DESC(transport_retry_time, "Packet retransmission timeout in msecs, used in case of buffer full. (default 20)");
>>>> ./transport.c:63:MODULE_PARM_DESC(transport_packet_delay, "Delay between packets to avoid buffer overruns (default 0)");
>>>
>>> Better convert them to netlink options.
>>>
>>
>> What about putting them into socket depended sockopts with setsockopt()?
>
> Is it a per interface or a per socket setting?
>

At least for iso-tp these kind of settings are transport channel 
specific. Don't know if this can be applied to j1939 too.

This is something Kurt or others can answer better than me.

Regards,
Oliver
