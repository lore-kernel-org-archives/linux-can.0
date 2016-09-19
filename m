From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: j1939
Date: Mon, 19 Sep 2016 20:27:53 +0200
Message-ID: <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:48489 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932272AbcISS2E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2016 14:28:04 -0400
In-Reply-To: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

On 09/19/2016 06:54 PM, Marc Kleine-Budde wrote:

>
> Another thing that IMHO has to be sorted out is the use of module
> parameters:
>
>> ./main.c:49:MODULE_PARM_DESC(padding, "Pad all packets to 8 bytes, and stuff with 0xff");
>> ./transport.c:60:MODULE_PARM_DESC(transport_burst_count, "Number of packets to send in burst between flow control (1..255, default 255)");
>> ./transport.c:61:MODULE_PARM_DESC(transport_max_size, "Maximum packet size (default 100k)");
>> ./transport.c:62:MODULE_PARM_DESC(transport_retry_time, "Packet retransmission timeout in msecs, used in case of buffer full. (default 20)");
>> ./transport.c:63:MODULE_PARM_DESC(transport_packet_delay, "Delay between packets to avoid buffer overruns (default 0)");
>
> Better convert them to netlink options.
>

What about putting them into socket depended sockopts with setsockopt()?

Regards,
Oliver


> Next think I'll do is to establish some communication with an external
> j1939 component. I'll keep you updated.
>
> regards,
> Marc
>
