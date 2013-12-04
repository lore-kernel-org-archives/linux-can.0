From: swapnil <patilswa@gmail.com>
Subject: Re: AW: Need support J1939 protocol support to my kernel (v3.8 on BeagleBone Black)
Date: Wed, 4 Dec 2013 22:10:38 +0000 (UTC)
Message-ID: <loom.20131204T225349-668@post.gmane.org>
References: <zarafa.5281024a.0b28.43b8b0d35b442ecc@v14647.1blu.de> <loom.20131112T015933-695@post.gmane.org> <20131112100222.GA3748@vandijck-laurijssen.be> <loom.20131128T053030-487@post.gmane.org> <20131128085233.GA3146@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38530 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab3LDWLA (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 4 Dec 2013 17:11:00 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VoKep-0002AG-2U
	for linux-can@vger.kernel.org; Wed, 04 Dec 2013 23:10:59 +0100
Received: from 192.158.48.18 ([192.158.48.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 04 Dec 2013 23:10:59 +0100
Received: from patilswa by 192.158.48.18 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 04 Dec 2013 23:10:59 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:

> 
> Hey,
> 
> > Hi Kurt ,
> >  Thanks for adding the information on elinux.org/J1939
> > I am able to build the kernal for begabone black using j1939 
> > but when i tried to build iproute2-j1939
> > 
> > root <at> arm:/home/ubuntu/OBDscan/iproute2-j1939# make
> > make[1]: Entering directory `/home/ubuntu/OBDscan/iproute2-j1939/misc'
> > gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -I../include -
> > DRESOLVE_HOSTNAMES -DLIBDIR=\"/usr/lib/\" -I/usr//usr/include  -o arpd 
> > arpd.c ../lib/libnetlink.a ../lib/libutil.a -ldb -lpthread
> > arpd.c:19:20: fatal error: db_185.h: No such file or directory
> >  #include <db_185.h>
> >                     ^
> > compilation terminated.
> > make[1]: *** [arpd] Error 1
> > make[1]: Leaving directory `/home/ubuntu/OBDscan/iproute2-j1939/misc'
> > make: *** [all] Error 2
> > 
> > i am getting above error.
> > i tried to install  sudo apt-get install db4.7-util
> > but did not worked 
> 
> you'd need some sort of db-devel package, as explained in README of 
iprout2.
> Another trick I initially did is disable arpd from building:
> in misc/Makefile, drop 'arpd' from TARGETS.
> 
> Kind regards,
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Hi Kurt,
      I commented out arpd part from building and it worked 
after that i replaced current IP with the new one.

After that i tried the sample program jspy it worked as expected on 
beaglebone black.
I have few questions
1.I want to transmit more than 8 bytes on can and want to check 
RTS->CTS->EOM  flow
2.I a able to receive 900 messages/sec on begalbone with 250k baud rate 
  actually it should receive 1600 messages ? i will try to figure it out? 
 

I think JSR program is used to transmit and receive j1939 packet 
but i am not able to  figure out how to send TP message 
can u give me simple example to send and receive J1939 tp message
I have canAlyzer.
          Also i want to post the document how I build j1939 for begalbone 
black.

Thank you for your support

