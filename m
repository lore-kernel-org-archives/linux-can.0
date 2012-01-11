From: Wolfgang <wutz@unterderbruecke.de>
Subject: promiscuous mode
Date: Wed, 11 Jan 2012 16:06:03 +0000 (UTC)
Message-ID: <loom.20120111T163604-92@post.gmane.org>
References: <20120109132638.GI386@e-circ.dyndns.org> <loom.20120109T162926-984@post.gmane.org> <20120110085105.GB330@e-circ.dyndns.org> <loom.20120110T112815-928@post.gmane.org> <20120110152341.GD2524@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46543 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757619Ab2AKQGV (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Jan 2012 11:06:21 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Rl0gt-0007C7-Aq
	for linux-can@vger.kernel.org; Wed, 11 Jan 2012 17:06:19 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2012 17:06:19 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2012 17:06:19 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

static struct {
	struct sockaddr_can src;
	int pkt_len;
} ss = {
	.pkt_len = 1024,
	.src.can_addr.j1939 = {
		.name = J1939_NO_NAME,
		.addr = J1939_NO_ADDR,
		.pgn = J1939_NO_PGN,
	},
};


int main (void)
{
	
	int s;
	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	    
	struct sockaddr_can addr;

    memset(&addr, 0, sizeof(addr));
    addr.can_ifindex = ss.src.can_ifindex;
    addr.can_addr.j1939.name = J1939_NO_NAME;    
    addr.can_addr.j1939.addr = J1939_NO_ADDR;
    addr.can_addr.j1939.pgn = J1939_NO_PGN;
    addr.can_family = AF_CAN;  
   
   
    if (bind(s, (void *)&addr, sizeof(addr))<0)
    	   		perror ("bind failed");
    	   	else
        		printf("bind of promiscuous socket successful\n");
        		     		
        		   	       	       	
    int s2;
	s2 = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	
	struct sockaddr_can addr2;	
	   
    memset(&addr2, 0, sizeof(addr2));
    addr2.can_ifindex = if_nametoindex("can1");
    addr2.can_addr.j1939.name = J1939_NO_NAME;    
    addr2.can_addr.j1939.addr = 0x3d;
    addr2.can_addr.j1939.pgn = J1939_NO_PGN;
    addr2.can_family = AF_CAN;     
   
    if (bind(s2, (void *)&addr2, sizeof(addr2))<0)
    	   		perror ("bind2 failed");
        	else
        		printf("bind of s2 on can1 addr 0x3d successful\n");
        		
        		
    int ret;
	socklen_t len; 
	struct sockaddr_can src_addr;
	char buf[128];
;
	
	
	while (1)
	 {
			
			len = sizeof(src_addr);
			ret = recvfrom(s, buf, sizeof(buf), 0, (void *)&src_addr, &len);
			if (ret < 0)
			perror ("recvfrom failed");
		
		}
			
	}					
	

  		 
  return 0;
}

It is working, is it possible to use it or do I have to use recvmsg, because
when I do sendto it is receiving the sent message again and again or is it
possible to clear the buffer somehow? Recvmsg is working as well but how do I 
have to change the sendto, 'sendto failed: Invalid argument'?


	
	static char ctrlmsg[
	CMSG_SPACE(sizeof(uint8_t)) /* dest addr */
	+ CMSG_SPACE(sizeof(uint64_t)) /* dest name */
	+ CMSG_SPACE(sizeof(uint8_t)) /* priority */
	];
	
static struct {
	struct sockaddr_can addr;
	int pkt_len;
} s = {
	.pkt_len = 1024,
	.addr.can_addr.j1939 = {
		.name = J1939_NO_NAME,
		.addr = J1939_NO_ADDR,
		.pgn = J1939_NO_PGN,
	},
};

int main (void)
{
   int sock, ret, j;
   unsigned int len;
   struct msghdr msg;
   struct iovec iov;
   static uint8_t *buf;
   struct sockaddr_can src;

	socklen_t leng; 
   
   
   	buf = malloc(s.pkt_len);
	if (!buf)
		error(1, errno, "malloc %u", s.pkt_len);
   
   sock = socket(PF_CAN,SOCK_DGRAM,CAN_J1939);
      
   
   memset(&src, 0, sizeof(src));
   src.can_ifindex = s.addr.can_ifindex;
   src.can_family = AF_CAN;
   src.can_addr.j1939.name = J1939_NO_NAME;
   src.can_addr.j1939.addr = J1939_NO_ADDR;
   src.can_addr.j1939.pgn = J1939_NO_PGN;
   
   bind(sock,(void*)&src,sizeof(src));
   len = sizeof(src);
   
   iov.iov_base = &buf[0];
   msg.msg_name = &src;
   msg.msg_iov = &iov;
   msg.msg_iovlen = 1;
   msg.msg_control = &ctrlmsg;
   
   msg.msg_namelen = len;
   
   
       int s2;
	s2 = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	
	struct sockaddr_can addr2;	
	   
    memset(&addr2, 0, sizeof(addr2));
    addr2.can_ifindex = if_nametoindex("can1");
    addr2.can_addr.j1939.name = J1939_NO_NAME;    
    addr2.can_addr.j1939.addr = 0x3d;
    addr2.can_addr.j1939.pgn = J1939_NO_PGN;
    addr2.can_family = AF_CAN;     
   
    if (bind(s2, (void *)&addr2, sizeof(addr2))<0)
    	   		perror ("bind2 failed");
        	else
        		printf("bind of s2 on can1 addr 0x3d successful\n");

   
   
	while (1) {
		/* these settings may be modified by recvmsg() */
		iov.iov_len = s.pkt_len;
		msg.msg_namelen = sizeof(src);
		msg.msg_controllen = sizeof(ctrlmsg);
		msg.msg_flags = 0;

		ret = recvmsg(sock, &msg, 0);
		
		
		len = ret;
		

			
			if ((sendto(s2, buf, ret, 0, (void *)&src, leng))<0);
			perror("sendto failed");
			
			
		
		}
		free(buf);
	
		
	return 0;
}

Thanks
Best regards,
Wolfgang


