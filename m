From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can: FD: configure transmitter delay
Date: Sat, 9 Dec 2017 19:01:38 +0100
Message-ID: <eb6253a6-706b-db3b-9701-3eef2e408d9c@hartkopp.net>
References: <B4DF4571-1790-4F09-8DEC-C0812D0F34B1@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:24153 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdLISBu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Dec 2017 13:01:50 -0500
In-Reply-To: <B4DF4571-1790-4F09-8DEC-C0812D0F34B1@martin.sperl.org>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Sperl <kernel@martin.sperl.org>
Cc: linux-can@vger.kernel.org

Hello Martin,

we had a discussion on this topic recently which ended here:

https://marc.info/?l=linux-can&m=150850171310828&w=2

There was no further discussion since then.

What is you opinion about using the 'data sample-point' aka 
dsample-point for transmitter delay configuration?

    $ ip link set can0 type can help
     Usage: ip link set DEVICE type can
         [ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
         [ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
           phase-seg2 PHASE-SEG2 [ sjw SJW ] ]

         [ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] | <<---
         [ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1
           dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]

Best regards,
Oliver

On 12/09/2017 06:01 PM, Martin Sperl wrote:
> Hi!
> 
> The mcp2517fd that I am finishing the driver for has some specific
> settings to configure the transmitter delay which is used with can fd
> frames (essentially it configures 2nd sample point that takes the
> delay /latency of the transceiver into account -  can be off, fixed, or
> automatic).
> 
> Compatibility tests have already shown that some can fd communication
> is quite sensitive to these settings - especially between different types
> of devices - which may result in BUS off situations...
> 
> So I am wondering how to best allow for configuration of these
> parameters - module parameters is ugly similarly debugfs or sysfs.
> 
> I guess there must be other fd devices with similar requirements,
> so I wonder how it is handled there...
> 
> Thanks,
>               Martin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
