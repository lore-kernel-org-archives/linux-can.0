From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: j1939: recv >8 bytes
Date: Fri, 25 Sep 2015 10:28:46 +0200
Message-ID: <20150925082846.GA7002@airbook>
References: <CAKoHjFzLoME76fmon+O7oS5_pKQk2j7QujnMsOfL7aLrr8xDWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:5566 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbbIYI3U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Sep 2015 04:29:20 -0400
Content-Disposition: inline
In-Reply-To: <CAKoHjFzLoME76fmon+O7oS5_pKQk2j7QujnMsOfL7aLrr8xDWg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark Santacesaria <mark@keeptruckin.com>
Cc: linux-can@vger.kernel.org

Hi Mark,

I added linux-can mailing list in CC, and altered the subject.
See my answer to your question below.

--- Original message ---
> Date: Thu, 24 Sep 2015 11:21:48 -0400
> From: Mark Santacesaria <mark@keeptruckin.com>
> To: kurt.van.dijck@eia.be
> Subject: j1939 linux kernel...
> 
>    hey kurt.... thanks for the effort that you put in to the j1939
>    code.... i was trying to receive a VIN request which is a multi-packet
>    message, and while i found examples of sending more that 8 bytes but i
>    am not sure how to receive.....

A "multi-packet message" is treated as a single j1939 packet.
You receive it like any other j1939 packet:
	
	uint8_t buf[1024];
	int ret;

	ret = recv(sock, buf, sizeof(buf), 0);

will receive up to 1024 bytes from the next j1939 packet.
You may use any buffer size you like here.

see also

	man recv

Kind regards,
Kurt
