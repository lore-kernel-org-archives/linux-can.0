From: linux-can@laure.nz
Subject: Re: Rx not working when not started from terminal
Date: Tue, 31 May 2016 12:13:11 +0200
Message-ID: <0aaed103-f91a-5409-ce1d-29840b87adeb@laure.nz>
References: <e0cee7e7-07c8-feac-7262-d62c020d07f7@laure.nz>
 <20160531100401.GB27305@airbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gacrux.uberspace.de ([185.26.156.53]:60670 "EHLO
	gacrux.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbcEaKNQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 May 2016 06:13:16 -0400
In-Reply-To: <20160531100401.GB27305@airbook>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org

Hi Kurt,

On 31.05.2016 12:04, Kurt Van Dijck wrote:
> So, to summarize: slcand does not work when started from udev
> and slcand does work when started in an interactive terminal.
Yes.
> can you insert a "sleep 1" in front of the slcand launch
> script?
With my launch script /usr/local/bin/slcan_add.sh:

    #!/bin/sh
    # Bind the USBCAN device
    sleep 1
    /usr/local/bin/slcand -o -c -f -s8 /dev/$1 slcan0
    sleep 2
    ifconfig slcan0 up

The sleep has no effect unfortunately.

Laurenz
