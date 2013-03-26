From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Parsing j1939 from raw candump
Date: Tue, 26 Mar 2013 20:18:31 +0100
Message-ID: <20130326191831.GA22696@vandijck-laurijssen.be>
References: <loom.20130325T214842-307@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from Mailrelay020.isp.belgacom.be ([195.238.6.95]:4649 "EHLO
	mailrelay020.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047Ab3CZTSo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 26 Mar 2013 15:18:44 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130325T214842-307@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Giox79 <giovanniparodi79@gmail.com>
Cc: linux-can@vger.kernel.org

On Mon, Mar 25, 2013 at 09:02:43PM +0000, Giox79 wrote:
> Hello everybody, I would like to ask some suggestion.
> As said in a previous post, I rebuilt candump utils on a 
> custom board with a can interface.
> I've been able to capture data using the 
> canlogserver  util and everything worked fine. 
> Now I would like to build a SW application, 
> running in a PC and receiving the data from canlogserver. 
> This application should parse raw candump packet and 
> extract j1939 packet.

> Is there anyone that can suggest me how to approach 
> this topic? I tried using the j1939-71 standard, 
> but as far as I understand, it explains differences between 
> different packages, but I didn't find an 
> explanation about header and trailer of J1939 packet.

j1939-21 & j1939-81
are the ones used by the j1939 linux kernel.

> Please note that I have the whole j1939 standard and that 
> at present time I can't integrate the j1939 canutils in linux 
> kernel because I should use for other kind of constraints 
> a 2.6 linux kernel.

which specific 2.6 one did it start from (like 2.6.28 or 2.6.35 or ...)

> Any help, reference to specific sections of j1939 standard
>  and so on will be appreciated.
> Giovanni
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
