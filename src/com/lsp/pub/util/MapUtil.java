package com.lsp.pub.util;

import java.util.ArrayList;
import java.util.List; 

import com.lsp.pub.entity.LatLng;
/**
 * 工具
 * @author lsp 
 *   
 */
public class MapUtil {
	/**
	 * 判断点是否在多边形内
	 * @param px 经度
	 * @param py 纬度
	 * @param polygonXA 经度
	 * @param polygonYA 纬度
	 * @return
	 */
	public  boolean isPointInPolygon(double px, double py,List<Double> polygonXA, List<Double> polygonYA) {   
        boolean isInside = false;   
        double ESP = 1e-9;   
        int count = 0;   
        double linePoint1x;   
        double linePoint1y;   
        double linePoint2x = 180;   
        double linePoint2y;   
  
        linePoint1x = px;   
        linePoint1y = py;   
        linePoint2y = py;   
  
        for (int i = 0; i < polygonXA.size() - 1; i++) {   
            double cx1 = polygonXA.get(i);   
            double cy1 = polygonYA.get(i);   
            double cx2 = polygonXA.get(i + 1);   
            double cy2 = polygonYA.get(i + 1);   
            if (isPointOnLine(px, py, cx1, cy1, cx2, cy2)){   
                return true;   
            }   
            if (Math.abs(cy2 - cy1) < ESP) {   
                continue;   
            }   
  
            if (isPointOnLine(cx1, cy1, linePoint1x, linePoint1y, linePoint2x,   
                    linePoint2y)) {   
                if (cy1 > cy2)   
                    count++;   
            } else if (isPointOnLine(cx2, cy2, linePoint1x, linePoint1y,   
                    linePoint2x, linePoint2y)) {   
                if (cy2 > cy1)   
                    count++;   
            } else if (isIntersect(cx1, cy1, cx2, cy2, linePoint1x,   
                    linePoint1y, linePoint2x, linePoint2y)) {   
                count++;   
            }   
        }   
        if (count % 2 == 1) {   
            isInside = true;   
        }   
  
        return isInside;   
    }   
  
    public  double Multiply(double px0, double py0, double px1, double py1,   
            double px2, double py2) {   
        return ((px1 - px0) * (py2 - py0) - (px2 - px0) * (py1 - py0));   
    }   
  /**
   * 判断点是否在线上
   * @param px0 经度
   * @param py0
   * @param px1 经度
   * @param py1
   * @param px2 经度
   * @param py2
   * @return
   */
    public  boolean isPointOnLine(double px0, double py0, double px1,   
            double py1, double px2, double py2) {   
        boolean flag = false;   
        double ESP = 1e-9;   
        if ((Math.abs(Multiply(px0, py0, px1, py1, px2, py2)) < ESP)   
                && ((px0 - px1) * (px0 - px2) <= 0)   
                && ((py0 - py1) * (py0 - py2) <= 0)) {   
            flag = true;   
        }   
        return flag;   
    }   
    /**
     * 判断是否相交
     * @param px1 经度
     * @param py1
     * @param px2 经度
     * @param py2
     * @param px3 经度
     * @param py3
     * @param px4 经度
     * @param py4
     * @return
     */
    public  boolean isIntersect(double px1, double py1, double px2, double py2,   
            double px3, double py3, double px4, double py4) {   
        boolean flag = false;   
        double d = (px2 - px1) * (py4 - py3) - (py2 - py1) * (px4 - px3);   
        if (d != 0) {   
            double r = ((py1 - py3) * (px4 - px3) - (px1 - px3) * (py4 - py3))   
                    / d;   
            double s = ((py1 - py3) * (px2 - px1) - (px1 - px3) * (py2 - py1))   
                    / d;   
            if ((r >= 0) && (r <= 1) && (s >= 0) && (s <= 1)) {   
                flag = true;   
            }   
        }   
        return flag;   
    }
    /**
     * 获取两点间的距离
     * @param lat1
     * @param lon1
     * @param lat2
     * @param lon2
     * @return
     */
    public  double getDistatce(double lat1, double lon1, double lat2, double lon2) { 
        double R = 6371; 
        double distance = 0.0; 
        double dLat = (lat2 - lat1) * Math.PI / 180; 
        double dLon = (lon2 - lon1) * Math.PI / 180; 
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) 
                + Math.cos(lat1 * Math.PI / 180) 
                * Math.cos(lat2 * Math.PI / 180) * Math.sin(dLon / 2) 
                * Math.sin(dLon / 2); 
        distance = (2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))) * R; 
        return distance; 
    }

    
    
    private static final double PI = 3.14159265358979323; //圆周率
    private static final double R = 6378137;              //地球的半径 
   
    public double getDegree(double distance){
    	return distance/((2*R*PI)/360);
    }
    
    /**
     * 路线矩形
     * @param list
     * @param distance
     * @return
     */
    public  List<List<LatLng>> lineToPPP(List<LatLng> list,double distance){
    	List<List<LatLng>> tempList=new ArrayList<List<LatLng>>();
    	for (int i=0;i<list.size();i++) { 
    		List<LatLng> ttC=circle(list.get(i),distance);
    		tempList.add(ttC);
    		if(i>0&&i<list.size()){
    			List<LatLng> ttD=circle(list.get(i-1),distance);
    			long tt1=angle(list.get(i-1),list.get(i));
    			long tt2=angle(list.get(i),list.get(i-1));
    			List<LatLng> ttP=new ArrayList<LatLng>();
				ttP.add(ttD.get(Math.round(hedee(tt1-9))));
				ttP.add(ttD.get(Math.round(hedee(tt1+9))));
				ttP.add(ttC.get(Math.round(hedee(tt2-9))));
				ttP.add(ttC.get(Math.round(hedee(tt2+9))));
				ttP.add(ttD.get(Math.round(hedee(tt1-9))));
				tempList.add(ttP);
    		}
    	}
    	
    	return tempList;
    }

    private  long hedee(long len){
    	if(len>36){
    		return len-36;
    	}else if(len<0){
    		return 36+len;
    	}else{
    		return len;
    	}
    }
    public  List<LatLng> circle(LatLng center, double radius){
    	List<LatLng> list=new ArrayList<LatLng>();
		double d2r =Math.PI/180;
		double clat = radius * 0.014483/1609.344;
		double clng = clat/Math.cos(center.getLat()*d2r); 
		for (int i=0; i < 37; i++) { 
			double theta = Math.PI * i/18.0;
			double cy = center.getLat() + (clat * Math.sin(theta));
			double cx = center.getLng() + (clng * Math.cos(theta));
			list.add(new LatLng(cy,cx));
	      }
		return list;
	}
    private  long angle(LatLng begin,LatLng after){    	
    	double lg=
    			Math.atan((after.getLat()-begin.getLat())/(after.getLng()-begin.getLng()))
    					*180/Math.PI/10;
    	if(after.getLng()==begin.getLng()){
    		if(after.getLat()>begin.getLat()){
    			return 9;
    		}else{
    			return 27;
    		}
    	}
    	if(after.getLat()>begin.getLat()){
    		if(lg<0){
    			return 18+Math.round(lg);
    		}else{
    			return Math.round(lg);
    		}
    	}else if(after.getLat()==begin.getLat()){
    		if(after.getLng()>begin.getLng()){
    			return 0;
    		}else{
    			return 18;
    		}
    		
    	}else{
    		if(lg<0){
    			return 36+Math.round(lg);
    		}else{
    			return Math.round(lg)+18;
    		}
    	}
    }
}
