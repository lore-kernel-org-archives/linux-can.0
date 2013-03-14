From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: CAN j1939 library doubts
Date: Thu, 14 Mar 2013 22:07:51 +0100
Message-ID: <20130314210751.GC1387@vandijck-laurijssen.be>
References: <loom.20130312T213038-40@post.gmane.org>
 <854F9BFD-752B-4B2B-A637-7310BCF8B7D2@emailplus.org>
 <20130313084248.GA449@vandijck-laurijssen.be>
 <loom.20130314T121737-364@post.gmane.org>
 <20130314122045.GD3382@vandijck-laurijssen.be>
 <loom.20130314T145923-349@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:58605 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751350Ab3CNVHz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Mar 2013 17:07:55 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130314T145923-349@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Giox79 <giovanniparodi79@gmail.com>
Cc: linux-can@vger.kernel.org

On Thu, Mar 14, 2013 at 04:20:08PM +0000, Giox79 wrote:
> Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:
> 
> In order to integrate your libs to my kernel, I was supposing to make a diff 
> between source file, looking mainly at can and iproute2, merge the diffs and 
> build the whole system.
> Do you think this is the right approach?
no. I (just) prepared the repositories to allow easy merges.

follow these steps (@Marc, can you just verify the 'git' calls):

git clone your kernel, or get a stable one
	$ git clone http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
... this takes time
	$ cd linux-stable
	$ git tag
choose a version, like v3.3, or v3.8, ...
	$ git checkout <chosen-version>
	$ git checkout -b <new-branch-name>
This last command creates a new branch, so you can play freely.
Now choose your branch on http://gitorious.org/~kurt-vd/linux-can/linux-can-j1939
, like j1939-v3.3
	$ git pull git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.git <gitorious-branch-name>

If this all went ok, then you're ready now.

The same applies for can-utils & iproute2.
You could also clone my j1939 versions directly if you do not care about
the precise versions, like:
	$ git clone -b <gitorious-branch-name> git://gitorious.org/~kurt-vd/linux-can/iproute2-j1939
with <gitorious-branch-name> something like 'j1939-v3.6'.
In contrast to the kernel, I never modify iproute2 besides j1939 stuff,
so this would work very fine.
Even an .tgz export could work then.

Kind regards,
Kurt
