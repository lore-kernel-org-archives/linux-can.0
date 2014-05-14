From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: regarding iproute2-j1939 package
Date: Wed, 14 May 2014 16:12:40 +0200
Message-ID: <20140514141240.GB27309@vandijck-laurijssen.be>
References: <5373669A.1020301@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:57610 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751103AbaENOMn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 May 2014 10:12:43 -0400
Content-Disposition: inline
In-Reply-To: <5373669A.1020301@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wed, May 14, 2014 at 06:20:34PM +0530, Ratheendran wrote:
> Hi All,
> 
> I want to use iproute2 available with 'git clone git@gitorious.org:linux-can/
> iproute2-j1939.git'
> 
> I noticed from the patch the some sub-directories missing in iproute-j1939
> package, need to understand if there is could lead to undesired consequences on
> iproute2 functionality on other protocols.
> 
> snapshot of the patch created from 'iproute2-3.10.0'
> --- iproute2-3.10.0/Makefile    2013-07-16 10:06:36.000000000 -0700
> +++ iproute2-j1939/Makefile    2014-05-05 03:00:29.000000000 -0700
> 
> -SUBDIRS=lib ip tc bridge misc netem genl man
> +SUBDIRS=lib ip tc misc netem genl

the iproute2-j1939 branch does not really follow the iproute2 development closely
due to time considerations.
The bridge & man subdirectory may have been added recently, that is perfectly possible.

older iproute2 versions, like the iproute2-j1939 that you have,
still work on recent kernels, but you may not be able to achieve settings
that became available recently.

With regard to can & j1939, the iproute-j1939 is still up to date I believe.

Kurt
