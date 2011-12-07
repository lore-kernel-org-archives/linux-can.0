From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using j1939: j1939.h
Date: Wed, 7 Dec 2011 15:50:32 +0100
Message-ID: <20111207145032.GE373@e-circ.dyndns.org>
References: <20111206104432.91170@gmx.net>
 <20111206121403.GB322@e-circ.dyndns.org>
 <loom.20111206T131950-88@post.gmane.org>
 <20111206131815.GD322@e-circ.dyndns.org>
 <loom.20111207T093827-478@post.gmane.org>
 <20111207143333.GD373@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:32484 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756284Ab1LGOue (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:50:34 -0500
Content-Disposition: inline
In-Reply-To: <20111207143333.GD373@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>, linux-can@vger.kernel.org

> I'm gonna work to indicate j1939.h status during ./configure ...
> It's these kind of small problems that I never encountered during
> development ...
I pushed 1 commit to can-j1939-utils.
$ ./autogen.sh
must be issued again. It will now show more explicit that SAE J1939
will be built or not.

> > 
> 
> Kurt
