From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: Web GUI for can-utils (i.e. cangw, cansend, candump)
Date: Wed, 19 Jun 2013 19:29:47 +0200
Message-ID: <51C1EA8B.3080403@hartkopp.net>
References: <zarafa.51bd74e8.76a4.36c61f7d6f480f71@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:35218 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708Ab3FSR3t (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Jun 2013 13:29:49 -0400
In-Reply-To: <zarafa.51bd74e8.76a4.36c61f7d6f480f71@v14647.1blu.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 16.06.2013 10:18, Michael Luxen wrote:

>> Usually we use it with localhost IP communication.
>> An in the rare cases we use a MPC5200@400MHz based embedded system with two
>> CAN interfaces without any problems so far.
> Can you explain your setup more in detail?

AFAIK Kayak was always running on a Linux Laptop in our setups.

And the socketcand was running on the same Linux Laptop or on the PowerPC
MPC5200. I must admit that i didn't look to CPU usage details. It was just
working for the purposes.

> I did several tests in the last days with:
> a) Kayak installed on the BeagleBone Black and export display to my Windows machine (using socketcand only on localhost)
> b) Kayak installed on my windows machine and connection via ethernet port of the BeagleBone Black via socketcand
> 
> Results for a) are that the socketcand process uses round abput 45% CPU (1GHz SoC) load at 37%@500kbit/s busload and a further socketcand process for DCAN1 increases the busload depending on the busload.
>  
> Results for b) are unacceptable due to very low speed of the exported Kayak application via MobaXterm.

Forwarding of display data is not very CPU / networking friendly.
The socketcand data is the only thing that should be transmitted via network.


> Further nice tools are:
> Webbased CANlogger using socketcan 
> https://bitbucket.org/Mongo/ewecan/overview
> 
> Qcanobserver - CAN sniffer Qt based
> http://qcanobserver.sourceforge.net/

Interesting!

> 
> As I'm fighting with getting my MCP2515 to work on a BeagleBone Black (Angstrom 2013-06-06 distribution)I'm very interested in getting a guideline/howto to get it working. 
> Does someone in the mailinglist have a working MCP2515 running with BeagleBone / BeagleBone Black.

Don't know.

You better start a new thread with a matching mail subject.

Best regards,
Oliver


