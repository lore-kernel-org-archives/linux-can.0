From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using j1939
Date: Mon, 12 Dec 2011 15:10:10 +0000 (UTC)
Message-ID: <loom.20111212T160733-221@post.gmane.org>
References: <loom.20111206T131950-88@post.gmane.org> <4EDE1785.9000306@volkswagen.de> <20111209134721.GA309@e-circ.dyndns.org> <loom.20111209T145701-227@post.gmane.org> <20111209143224.GB309@e-circ.dyndns.org> <20111209144911.144460@gmx.net> <20111209150133.GA1470@e-circ.dyndns.org> <loom.20111209T175414-826@post.gmane.org> <20111212081217.GA351@e-circ.dyndns.org> <loom.20111212T121257-904@post.gmane.org> <20111212124031.GD351@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49639 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab1LLPK1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 12 Dec 2011 10:10:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Ra7WK-0003cA-6p
	for linux-can@vger.kernel.org; Mon, 12 Dec 2011 16:10:26 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 Dec 2011 16:10:24 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 Dec 2011 16:10:24 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I am sorry next error:

CHK     include/linux/version.h                                                
                                                                               
         
  CHK     include/linux/utsrelease.h                                           
                                                                               
           
  SYMLINK include/asm -> include/asm-powerpc                                   
                                                                               
           
  CALL    scripts/checksyscalls.sh                                             
                                                                               
           
  CHK     include/linux/compile.h                                              
                                                                               
           
  CALL    arch/powerpc/kernel/systbl_chk.sh                                    
                                                                               
           
  CC      net/can/bcm.o                                                        
                                                                               
           
net/can/bcm.c: In function 'bcm_proc_getifname':                               
                                                                               
           
net/can/bcm.c:150: error: implicit declaration of function
'dev_get_by_index_rcu'                                                         
                                
net/can/bcm.c:150: warning: assignment makes pointer from integer without a cast
                                                                               
          
  CC      net/can/gw.o                                                         
                                                                               
           
net/can/bcm.c: In function 'bcm_recvmsg':                                      
                                                                               
           
net/can/bcm.c:1559: error: implicit declaration of function
'sock_recv_ts_and_drops'                                                       
                               
make[3]: *** [net/can/bcm.o] Error 1                                           
                                                                               
           
make[3]: *** Waiting for unfinished jobs....
  CC      drivers/net/can/dev.o
net/can/gw.c: In function 'cgw_module_init':
net/can/gw.c:928: error: too many arguments to function '__rtnl_register'
net/can/gw.c:935: error: too many arguments to function '__rtnl_register'
net/can/gw.c:936: error: too many arguments to function '__rtnl_register'
make[3]: *** [net/can/gw.o] Error 1
make[2]: *** [net/can] Error 2
make[1]: *** [net] Error 2
make[1]: *** Waiting for unfinished jobs....
  CC      drivers/net/can/mscan/mscan.o
  CC      drivers/net/can/mscan/mpc52xx_can.o
  LD      drivers/net/can/can-dev.o
  LD      drivers/net/can/mscan/mscan-mpc52xx.o
  LD      drivers/net/can/mscan/built-in.o
  LD      drivers/net/can/built-in.o
  LD      drivers/net/built-in.o
  LD      drivers/built-in.o

--Wolfgang


