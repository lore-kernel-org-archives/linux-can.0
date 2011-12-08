From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: using j1939: userspace binaries
Date: Thu, 8 Dec 2011 13:30:04 +0100
Message-ID: <20111208123004.GA964@e-circ.dyndns.org>
References: <20111206104432.91170@gmx.net>
 <20111206121403.GB322@e-circ.dyndns.org>
 <loom.20111206T131950-88@post.gmane.org>
 <20111206131815.GD322@e-circ.dyndns.org>
 <loom.20111207T093827-478@post.gmane.org>
 <20111207143333.GD373@e-circ.dyndns.org>
 <20111207145032.GE373@e-circ.dyndns.org>
 <loom.20111208T120006-91@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:18385 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab1LHMaK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 Dec 2011 07:30:10 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111208T120006-91@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 08, 2011 at 12:23:47PM +0000, Wolfgang wrote:
> Now everything worked fine and I was able compile can-j1939-utils,
> iproute2-j1939 and I got two directories with $.../usr/bin.
great!
> 
> Where do I have to place this 2 folders now
all binaries in ..../usr/bin should go in /usr/bin on the target.

Kurt
