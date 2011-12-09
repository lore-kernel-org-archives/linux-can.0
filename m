From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: iproute2-j1939
Date: Fri, 09 Dec 2011 07:55:26 +0100
Message-ID: <4EE1B0DE.3040607@volkswagen.de>
References: <loom.20111206T131950-88@post.gmane.org> <20111206131815.GD322@e-circ.dyndns.org> <loom.20111207T093827-478@post.gmane.org> <20111207143333.GD373@e-circ.dyndns.org> <20111207145032.GE373@e-circ.dyndns.org> <loom.20111208T120006-91@post.gmane.org> <20111208123004.GA964@e-circ.dyndns.org> <loom.20111208T134455-791@post.gmane.org> <20111208133213.GB964@e-circ.dyndns.org> <loom.20111208T150123-262@post.gmane.org> <20111208151917.GE964@e-circ.dyndns.org> <loom.20111208T171058-366@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:50099 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab1LIGzd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Dec 2011 01:55:33 -0500
In-Reply-To: <loom.20111208T171058-366@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

Am 08.12.2011 17:44, schrieb Wolfgang:
> OK, I should read all posts not only the last one.
>
> I made:
> with the new one
>
> $iproute2-j1939>  make CC=powerpc-603e-linux-gnu-gcc
>
> same error "AF-CAN" undeclared
>
>
>
> $can-j1939-modules>make KERNEL_DIR=<...>  C=powerpc-603e-linux\
> -gnu-gcc
>
> make[1]: *** No rule to make target `modules'.  Stop.
> make: *** [modules] Error 2
>
> So do you think I have to replace the can.h in the
> kernel_header_path
> (/,.../sysroot-target/kernel-headers/include/linux)?

What do you use for KERNEL_DIR=<..> ??
Can you send the complete line?

Regards,
Oliver

