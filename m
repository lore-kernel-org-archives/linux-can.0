From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Session 152 terminated -- received PADT from peer
Date: Mon, 17 Jul 2017 09:11:18 +0200
Message-ID: <069e248e-a0ef-b21b-0272-a7fb3b831db0@hartkopp.net>
References: <CAGc3wVBAcgaGFtzDVTksaLgs0CX=mirK7osVJRNM2_JjtNYM6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:24656 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdGQHOe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2017 03:14:34 -0400
In-Reply-To: <CAGc3wVBAcgaGFtzDVTksaLgs0CX=mirK7osVJRNM2_JjtNYM6w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sekar D <sekar.linux@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Sekar,

linux-can mailing list is related to the CAN bus (Controller Area 
Network) - you probably did not want to post here, right? ;-)

Regards,
Oliver

On 07/17/2017 08:37 AM, Sekar D wrote:
> Hello All,
>
> I am getting the following error messages through PPP connection
> without any manual intervention.
>
> Session 152 terminated -- received PADT from peer
> PADT: Generic-Error: RP-PPPoE: Child pppd process terminated
> Sent PADT
> Modem hangup
> Exit
> Connection terminated.
> ADSL connection lost; attempting re-connection
>
>
> Please let me know if any configuration needs to be added.
>
> /etc/ppp/pppoe-server-options
> # PPP options for the PPPoE server
> # LIC: GPL
> require-chap
> login
> lcp-echo-interval 10
> lcp-echo-failure 2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
