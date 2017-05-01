From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can multiple processes bind an ISO-TP socket with the same
 (transfer ID, receive ID) pair?
Date: Mon, 1 May 2017 12:21:55 +0200
Message-ID: <6047f153-2c4f-2f91-94e4-ac65e0b14f3d@hartkopp.net>
References: <05D8E7B3-BE7C-42EA-8A54-601336A58205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:19153 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1952203AbdEAKV7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 May 2017 06:21:59 -0400
In-Reply-To: <05D8E7B3-BE7C-42EA-8A54-601336A58205@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ethan Vaughan <ejvaughan@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Ethan,

On 05/01/2017 06:53 AM, Ethan Vaughan wrote:

> I’m using your ISO-TP Linux driver in a project, and I was wondering about multi-application support.
 > Specifically, can multiple processes each bind an ISO-TP socket to 
the same (transfer ID, receive ID) pair,
 > as long as they synchronize their reads & writes? Or are the 
semantics like that of BSD sockets, where binding to a port that is 
already in use will fail?

There is no check inside Linux whether you create multiple ISO-TP 
sockets using the same CAN ID pair.

BUT: When you create an ISO-TP socket you instantiate two state machines 
(for TX and RX) which interact on the CAN bus (e.g. sending ACKs).

When you create two identical ISO-TP sockets your system won't crash but 
you create a big mess on the bus and render the protocol unusable.

You can switch the ISO-TP socket into some 'wire tap mode' to sniff PDUs 
without sending ACKs (see isotpsniffer.c). But this is more intended for 
logging/testing.

But for a multi-application access to ISO-TP sockets you will need to 
create some dispatcher process (e.g. daemon) which connects to *one* 
ISO-TP socket and provides e.g. some IP service to the 'multi-applications'.

Best regards,
Oliver

ps. +linux-can ML in CC as it might be interesting for other users too




