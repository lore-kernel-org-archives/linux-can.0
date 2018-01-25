From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 4/4] j1939: remove proc support
Date: Thu, 25 Jan 2018 10:32:06 +0100
Message-ID: <20180125093206.GB30696@airbook.vandijck-laurijssen.be>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
 <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
 <bc7051ae-846c-dc73-c177-ef7306e85320@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:55120 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbeAYJcy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jan 2018 04:32:54 -0500
Content-Disposition: inline
In-Reply-To: <bc7051ae-846c-dc73-c177-ef7306e85320@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org

> On 01/24/2018 09:13 PM, Kurt Van Dijck wrote:
> > I'm in favor of stripping all unnecessary, but ...
> 
> [...]
> 
> >> -  7 can-j1939 SYSCTL
> >> -    7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
> >> -    7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
> >> -    7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms
> > 
> > Those parameters shape the kernels behaviour on transport sessions.
> > It makes sense to configure them globally.
> > Should this be returned to module parameters then?
> I've split up the patch and removed the procfs for now, but the sysctl
> support stays in. I even have taken two more of Oleksij's patches that
> update the sysctl related parts of the documentation.

Sounds fair.
Don't thow the procfs away too far :-)

Kurt
